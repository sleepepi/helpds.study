# frozen_string_literal: true

require "test_helper"

# Should test getting a new report row.
class ReportRowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
  end

  test "should get new" do
    login(@admin)
    get new_report_row_url(format: "js"), xhr: true
    assert_response :success
  end
end
