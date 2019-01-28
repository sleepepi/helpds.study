# frozen_string_literal: true

# Allows admins to approve new users and set user roles.
class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!
  before_action :find_user_or_redirect, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /admin/users
  def index
    scope = User.current.search_any_order(params[:search])
    @users = scope_order(scope).page(params[:page]).per(40)
  end

  # # GET /admin/users/1
  # def show
  # end

  # PATCH /admin/users/1
  def update
    if @user.update(user_params)
      @user.check_approval_email
      redirect_to admin_user_path(@user), notice: "User was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  protected

  def find_user_or_redirect
    @user = User.current.find_by(id: params[:id])
    empty_response_or_root_path(admin_users_path) unless @user
  end

  def user_params
    params.require(:user).permit(
      :username, :full_name, :email, :approved, :admin, :editor, :role,
      :key_contact, :phone, :keywords, :site_id
    )
  end

  def scope_order(scope)
    @order = params[:order]
    scope.order(Arel.sql(User::ORDERS[params[:order]] || User::DEFAULT_ORDER))
  end
end
