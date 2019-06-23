# frozen_string_literal: true

require "application_system_test_case"

# Test for admins to view reports.
class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)
    @admin = users(:admin)
  end

  test "visit the index" do
    visit_login(@admin)
    visit reports_url
    assert_selector "h1", text: "Reports"
    screenshot("visit-reports-index")
  end

  test "create a report" do
    visit_login(@admin)
    visit reports_url
    screenshot("create-a-report")
    click_on "New report"
    select projects(:one).name, from: "report[project_id]"
    select "Expressions by Site", from: "report[report_type]"
    fill_in "report[name]", with: "Report One"
    screenshot("create-a-report")
    click_on "Create Report"
    assert_text "Report was successfully created"
    assert_selector "h1", text: "Reports"
    screenshot("create-a-report")
  end

  test "update a report" do
    visit_login(@admin)
    visit reports_url
    screenshot("update-a-report")
    click_on "Actions", match: :first
    screenshot("update-a-report")
    click_on "Edit"
    fill_in "report[name]", with: "Updated Name"
    screenshot("update-a-report")
    click_on "Update Report"
    assert_text "Report was successfully updated"
    assert_selector "h1", text: "Reports"
    screenshot("update-a-report")
  end

  test "destroy a report" do
    visit_login(@admin)
    visit reports_url
    screenshot("destroy-a-report")
    click_on "Actions", match: :first
    page.accept_confirm do
      click_on "Delete"
    end
    assert_text "Report was successfully deleted"
    screenshot("destroy-a-report")
  end
end
