# frozen_string_literal: true

# Allows sites to be viewed and added.
class SitesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_editor!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_site_or_redirect, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /sites
  def index
    scope = Site.current.search_any_order(params[:search])
    @sites = scope_order(scope).page(params[:page]).per(20)
  end

  # GET /recruiting-centers
  def recruiting_centers
    scope = Site.current.where(center_type: "recruiting").search_any_order(params[:search])
    @sites = scope_order(scope).page(params[:page]).per(20)
  end

  # GET /coordinating-centers
  def coordinating_centers
    scope = Site.current.where(center_type: %w(data clinical)).search_any_order(params[:search])
    @sites = scope_order(scope).page(params[:page]).per(20)
  end

  # # GET /sites/1
  # def show
  # end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # # GET /sites/1/edit
  # def edit
  # end

  # POST /sites
  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to @site, notice: "Site was successfully created."
    else
      render :new
    end
  end

  # PATCH /sites/1
  def update
    if @site.update(site_params)
      redirect_to @site, notice: "Site was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /sites/1
  def destroy
    @site.destroy
    redirect_to sites_path, notice: "Site was successfully deleted."
  end

  private

  def find_site_or_redirect
    @site = Site.find_by_param(params[:id])
    empty_response_or_root_path(sites_path) unless @site
  end

  def site_params
    params.require(:site).permit(:name, :slug, :center_type, :archived)
  end

  def scope_order(scope)
    @order = params[:order]
    scope.order(Arel.sql(Site::ORDERS[params[:order]] || Site::DEFAULT_ORDER))
  end
end
