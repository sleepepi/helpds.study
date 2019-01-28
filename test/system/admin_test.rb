# frozen_string_literal: true

require "application_system_test_case"

# System tests for admin pages.
class AdminTest < ApplicationSystemTestCase
  setup do
    @admin = users(:admin)
  end

  test "visit admin dashboard page" do
    visit_login(@admin)
    visit admin_url
    screenshot("visit-admin-dashboard-page")
    assert_selector "div", text: "Debug"
  end

  test "visit admin debug page" do
    visit_login(@admin)
    visit admin_debug_url
    screenshot("visit-admin-debug-page")
    assert_selector "div", text: "Debug"
  end
end
