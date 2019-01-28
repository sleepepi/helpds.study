# frozen_string_literal: true

require "application_system_test_case"

# Test internal pages.
class InternalTest < ApplicationSystemTestCase
  setup do
    @viewer = users(:viewer)
  end

  test "visit dashboard" do
    visit_login(@viewer)
    visit dashboard_url
    screenshot("visit-dashboard")
    assert_selector "h1", text: "Dashboard"
  end

  test "visit directory" do
    visit_login(@viewer)
    visit directory_url
    screenshot("visit-directory")
    assert_selector "h1", text: "Directory"
  end

  test "visit randomizations" do
    visit_login(@viewer)
    visit randomizations_url
    screenshot("visit-randomizations")
    assert_selector "h1", text: "Randomizations"
  end

  test "visit data health" do
    visit_login(@viewer)
    visit data_health_url
    screenshot("visit-data-health")
    assert_selector "h1", text: "Data Health"
  end

  test "visit report card" do
    visit_login(@viewer)
    visit report_card_url
    screenshot("visit-report-card")
    assert_selector "h1", text: "Report Card"
  end

  test "visit search" do
    visit_login(@viewer)
    visit search_url
    screenshot("visit-search")
    assert_selector "h1", text: "Search"
  end

  test "visit pareto chart" do
    visit_login(@viewer)
    visit pareto_url
    sleep(1.0) # Allow time to animate chart
    screenshot("visit-pareto-chart")
    assert_selector "h1", text: "Pareto"
  end
end
