# frozen_string_literal: true

require "test_helper"

# Allow admins to create and update reports.
class ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @project = projects(:one)
    @report = reports(:one)
  end

  def report_params
    {
      project_id: projects(:one).id,
      report_type: "expressions_by_site",
      name: "New Report",
      header_label: "Diagnosis",
      archived: "0",
      row_hashes: [
        {
          label: "Label 1",
          expression: "1 = 1"
        },
        {
          label: "Label 2",
          expression: "1 = 0"
        }
      ]
    }
  end

  test "should get index" do
    login(@admin)
    get reports_url
    assert_response :success
  end

  test "should get new" do
    login(@admin)
    get new_report_url
    assert_response :success
  end

  test "should create report" do
    login(@admin)
    assert_difference("ReportRow.count", 2) do
      assert_difference("Report.count") do
        post reports_url, params: { report: report_params }
      end
    end
    assert_redirected_to report_url(Report.last)
  end

  test "should show expressions by site report" do
    login(@admin)
    get report_url(@report)
    assert_response :success
  end

  test "should show randomizations by site report" do
    login(@admin)
    get report_url(reports(:randomizations))
    assert_response :success
  end

  test "should get edit" do
    login(@admin)
    get edit_report_url(@report)
    assert_response :success
  end

  test "should update report" do
    login(@admin)
    patch report_url(@report), params: { report: report_params }
    assert_redirected_to report_url(@report)
  end

  test "should destroy report" do
    login(@admin)
    assert_difference("Report.count", -1) do
      delete report_url(@report)
    end

    assert_redirected_to reports_url
  end
end
