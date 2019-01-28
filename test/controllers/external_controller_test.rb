# frozen_string_literal: true

require "test_helper"

# Test public pages.
class ExternalControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get root_url
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success
  end

  test "should get privacy policy" do
    get privacy_policy_url
    assert_response :success
  end

  test "should get version" do
    get version_url
    assert_response :success
  end

  test "should get version as json" do
    get version_url(format: "json")
    version = JSON.parse(response.body)
    assert_equal HelpDS::VERSION::STRING, version["version"]["string"]
    assert_equal HelpDS::VERSION::MAJOR, version["version"]["major"]
    assert_equal HelpDS::VERSION::MINOR, version["version"]["minor"]
    assert_equal HelpDS::VERSION::TINY, version["version"]["tiny"]
    if HelpDS::VERSION::BUILD.nil?
      assert_nil version["version"]["build"]
    else
      assert_equal HelpDS::VERSION::BUILD, version["version"]["build"]
    end
    assert_response :success
  end
end
