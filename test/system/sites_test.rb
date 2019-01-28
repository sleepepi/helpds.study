# frozen_string_literal: true

require "application_system_test_case"

# Test navigating and creating sites.
class SitesTest < ApplicationSystemTestCase
  setup do
    @site = sites(:ccc)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  test "visit sites index" do
    visit_login(@viewer)
    visit sites_url
    assert_selector "h1", text: "Sites"
    screenshot("visit-sites-index")
  end

  test "visit site" do
    visit_login(@viewer)
    visit site_url(@site)
    assert_selector "h1", text: "CCC"
    screenshot("visit-site")
  end

  test "create a site" do
    visit_login(@editor)
    visit sites_url
    screenshot("create-a-site")
    click_on "Add site"
    fill_in "site[name]", with: "Site A"
    # fill_in "site[slug]", with: "site-a"
    select "Recruiting Center", from: "site[center_type]"
    screenshot("create-a-site")
    click_on "Create Site"
    assert_text "Site was successfully created"
    assert_selector "h1", text: "Site A"
    screenshot("create-a-site")
  end

  test "update a site" do
    visit_login(@editor)
    visit site_url(@site)
    screenshot("update-a-site")
    find("i[class='fas fa-cogs']").click
    fill_in "site[name]", with: "Updated Name"
    fill_in "site[slug]", with: "updated-name"
    select "Clinical Coordinating Center", from: "site[center_type]"
    screenshot("update-a-site")
    click_on "Update Site"
    assert_text "Site was successfully updated"
    assert_selector "h1", text: "Updated Name"
    screenshot("update-a-site")
  end

  test "destroy a site" do
    visit_login(@editor)
    visit sites_url
    screenshot("destroy-a-site")
    # click_on "Actions", match: :second # The following is emulating this.
    page.all(".dropdown-toggle")[2].click
    screenshot("destroy-a-site")
    page.accept_confirm do
      click_on "Delete"
    end
    assert_text "Site was successfully deleted"
    screenshot("destroy-a-site")
  end

  test "visit recruiting centers page" do
    visit_login(@viewer)
    visit recruiting_centers_url
    assert_selector "h1", text: "Recruiting Centers"
    screenshot("visit-recruiting-centers-page")
  end

  test "visit coordinating centers page" do
    visit_login(@viewer)
    visit coordinating_centers_url
    assert_selector "h1", text: "Coordinating Centers"
    screenshot("visit-coordinating-centers-page")
  end
end
