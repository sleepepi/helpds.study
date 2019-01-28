# frozen_string_literal: true

require "test_helper"

# Tests to assure users can view sites and editors can manage sites.
class SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = sites(:ccc)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  def site_params
    {
      name: "New Site",
      slug: "new-site",
      center_type: "recruiting",
      archived: "0"
    }
  end

  test "should get index as viewer" do
    login(@viewer)
    get sites_url
    assert_response :success
  end

  test "should get new as editor" do
    login(@editor)
    get new_site_url
    assert_response :success
  end

  test "should not get new as viewer" do
    login(@viewer)
    get new_site_url
    assert_redirected_to dashboard_url
  end

  test "should create site as editor" do
    login(@editor)
    assert_difference("Site.count") do
      post sites_url, params: { site: site_params }
    end
    assert_redirected_to site_url(Site.last)
  end

  test "should not create site as viewer" do
    login(@viewer)
    assert_difference("Site.count", 0) do
      post sites_url, params: { site: site_params }
    end
    assert_redirected_to dashboard_url
  end

  test "should show site as viewer" do
    login(@viewer)
    get site_url(@site)
    assert_response :success
  end

  test "should get edit as editor" do
    login(@editor)
    get edit_site_url(@site)
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer)
    get edit_site_url(@site)
    assert_redirected_to dashboard_url
  end

  test "should update site as editor" do
    login(@editor)
    patch site_url(@site), params: { site: site_params }
    @site.reload
    assert_redirected_to site_url(@site)
  end

  test "should not update site as viewer" do
    login(@viewer)
    patch site_url(@site), params: { site: site_params }
    @site.reload
    assert_redirected_to dashboard_url
  end

  test "should destroy site as editor" do
    login(@editor)
    assert_difference("Site.current.count", -1) do
      delete site_url(@site)
    end
    assert_redirected_to sites_url
  end

  test "should not destroy site as viewer" do
    login(@viewer)
    assert_difference("Site.current.count", 0) do
      delete site_url(@site)
    end
    assert_redirected_to dashboard_url
  end

  test "should get coordinating centers as viewer" do
    login(@viewer)
    get coordinating_centers_url
    assert_response :success
  end

  test "should get recruiting centers as viewer" do
    login(@viewer)
    get recruiting_centers_url
    assert_response :success
  end
end
