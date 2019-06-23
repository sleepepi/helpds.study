# frozen_string_literal: true

# Allow admin to create and update report pages.
class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!
  before_action :find_page_or_redirect, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # POST /pages/add-report.js
  def add_report
    @report = Report.new
  end

  # GET /reports
  def index
    scope = Page.all.search_any_order(params[:search])
    @pages = scope_order(scope).page(params[:page]).per(20)
  end

  # # GET /pages/1
  # def show
  # end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # # GET /pages/1/edit
  # def edit
  # end

  # POST /pages
  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to @page, notice: "Page was successfully created."
    else
      render :new
    end
  end

  # PATCH /pages/1
  def update
    if @page.update(page_params)
      redirect_to @page, notice: "Page was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy
    redirect_to pages_path, notice: "Page was successfully deleted."
  end

  private

  def find_page_or_redirect
    @page = Page.find_by_param(params[:id])
    empty_response_or_root_path(pages_path) unless @page
  end

  def page_params
    params.require(:page).permit(
      :name, :slug, :position, :archived,
      report_hashes: [
        :report_id
      ]
    )
  end

  def scope_order(scope)
    @order = params[:order]
    scope.order(Arel.sql(Page::ORDERS[params[:order]] || Page::DEFAULT_ORDER))
  end
end
