# frozen_string_literal: true

require "test_helper"

# Tests to assure admin configure site..
class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @regular = users(:regular)
  end

  test "should get dashboard as admin" do
    login(@admin)
    get admin_url
    assert_response :success
  end

  test "should not get dashboard as editor" do
    login(@editor)
    get admin_url
    assert_redirected_to dashboard_url
  end

  test "should not get dashboard as regular" do
    login(@regular)
    get admin_url
    assert_redirected_to dashboard_url
  end

  test "should not get dashboard as public user" do
    get admin_url
    assert_redirected_to new_user_session_url
  end

  test "should get debug as admin" do
    login(@admin)
    get admin_debug_url
    assert_response :success
  end
end
