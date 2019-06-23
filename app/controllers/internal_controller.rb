# frozen_string_literal: true

# Internal pages.
class InternalController < ApplicationController
  before_action :authenticate_user!

  layout "layouts/full_page_sidebar"

  # GET /dashboard
  def dashboard
    @featured_documents = Document.featured_files.limit(10)
    @top_documents = Document.top_files.limit(5)
  end

  # GET /directory
  def directory
    @users = User.current.where(approved: true).order(id: :desc).limit(20)
    @key_contacts = User.current.where(key_contact: true)
  end

  # # GET /data-health
  # def data_health
  # end

  # # GET /report-card
  # def report_card
  # end

  # GET /search
  def search
    @search_documents = find_search_documents
    render layout: "layouts/full_page"
  end

  # # GET /pareto
  # def pareto
  # end

  # GET /report/:page_id
  def report_page
    @page = Page.where(archived: false).find_by_param(params[:page_id])
    redirect_to root_path unless @page
  end

  private

  # def scope_order(scope)
  #   @order = params[:order]
  #   scope.order(Arel.sql(User::ORDERS[params[:order]] || User::DEFAULT_ORDER))
  # end

  def find_search_documents
    params[:search]&.squish!
    if params[:search].present?
      PgSearchDocument
        .search_any_order(params[:search])
        .page(params[:page]).per(10)
    else
      PgSearchDocument.none
    end
  end
end
