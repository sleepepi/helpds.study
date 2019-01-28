# frozen_string_literal: true

# Allows editors to manage categories.
class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_editor!
  before_action :find_category_or_redirect, only: [:edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /categories/reorder
  def reorder
    @categories = Category.order_by_position
  end

  # POST /categories/reorder.js
  def update_order
    params[:category_ids].each_with_index do |category_id, index|
      Category.find_by(id: category_id)&.update(position: index)
    end
    head :ok
  end

  # # GET /categories/edit
  # def edit
  # end

  # PATCH /categories/1
  def update
    if @category.update(category_params)
      FilesJob.perform_later
      redirect_to reorder_categories_path, notice: "Category was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    FilesJob.perform_later
    redirect_to reorder_categories_path, notice: "Category was successfully deleted."
  end

  private

  def find_category_or_redirect
    @category = Category.find_by_param(params[:id])
    empty_response_or_root_path(reorder_categories_path) unless @category
  end

  def category_params
    params.require(:category).permit(
      :name, :slug, :archived
    )
  end
end
