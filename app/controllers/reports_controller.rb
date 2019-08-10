# frozen_string_literal: true

# Allow admin to configure reports.
class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!
  before_action :find_report_or_redirect, only: [
    :show, :edit, :update, :destroy, :refresh
  ]

  layout "layouts/full_page_sidebar"

  # POST /reports/:id/refresh
  def refresh
    status = @report.refresh!
    if status.is_a?(Net::HTTPOK)
      flash[:notice] = "Report was successfully refreshed."
    else
      flash[:notice] = "Refresh failed: #{status&.code} #{status&.message}"
    end
    redirect_to @report
  end

  # GET /reports
  def index
    scope = Report.all.search_any_order(params[:search])
    @reports = scope_order(scope).page(params[:page]).per(20)
  end

  # # GET /reports/:id
  # def show
  # end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # # GET /reports/:id/edit
  # def edit
  # end

  # POST /reports
  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to @report, notice: "Report was successfully created."
    else
      render :new
    end
  end

  # PATCH /reports/:id
  def update
    if @report.update(report_params)
      redirect_to @report, notice: "Report was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /reports/:id
  def destroy
    @report.destroy
    redirect_to reports_path, notice: "Report was successfully deleted."
  end

  private

  def find_report_or_redirect
    @report = Report.find_by(id: params[:id])
    empty_response_or_root_path(reports_path) unless @report
  end

  def report_params
    params.require(:report).permit(
      :project_id, :report_type, :name, :header_label, :sites_enabled,
      :archived, :filter_expression, :group_expression, :description,
      row_hashes: [
        :report_row_id, :label, :expression, :muted
      ]
    )
  end

  def scope_order(scope)
    @order = params[:order]
    scope.order(Arel.sql(Report::ORDERS[params[:order]] || Report::DEFAULT_ORDER))
  end
end
