# frozen_string_literal: true

require "test_helper"

# Test internal pages.
class InternalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewer = users(:viewer)
  end

  test "should get dashboard" do
    login(@viewer)
    get dashboard_url
    assert_response :success
  end

  test "should get directory" do
    login(@viewer)
    get directory_url
    assert_response :success
  end

  test "should get search" do
    login(@viewer)
    get search_url
    assert_response :success
  end

  test "should get pareto chart" do
    login(@viewer)
    get pareto_url
    assert_response :success
  end
end
