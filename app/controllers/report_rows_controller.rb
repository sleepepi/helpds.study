# frozen_string_literal: true

# Allow admins to add new rows to reports.
class ReportRowsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!

  # GET /report-rows/new.js
  def new
    @report_row = ReportRow.new
  end
end
