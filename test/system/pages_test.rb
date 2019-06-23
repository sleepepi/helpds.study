# frozen_string_literal: true

require "application_system_test_case"

# Test for admins to view pages.
class PagesTest < ApplicationSystemTestCase
  setup do
    @page = pages(:one)
    @admin = users(:admin)
  end

  test "visit the index" do
    visit_login(@admin)
    visit pages_url
    assert_selector "h1", text: "Pages"
    screenshot("visit-pages-index")
  end

  test "create a page" do
    visit_login(@admin)
    visit pages_url
    screenshot("create-a-page")
    click_on "New page"
    fill_in "page[name]", with: "Page One"
    fill_in "page[position]", with: "1"
    screenshot("create-a-page")
    click_on "Create Page"
    assert_text "Page was successfully created"
    assert_selector "h1", text: "Pages"
    screenshot("create-a-page")
  end

  test "update a page" do
    visit_login(@admin)
    visit pages_url
    screenshot("update-a-page")
    click_on "Actions", match: :first
    screenshot("update-a-page")
    click_on "Edit"
    fill_in "page[name]", with: "Updated Name"
    screenshot("update-a-page")
    click_on "Update Page"
    assert_text "Page was successfully updated"
    assert_selector "h1", text: "Pages"
    screenshot("update-a-page")
  end

  test "destroy a page" do
    visit_login(@admin)
    visit pages_url
    screenshot("destroy-a-page")
    click_on "Actions", match: :first
    page.accept_confirm do
      click_on "Delete"
    end
    assert_text "Page was successfully deleted"
    screenshot("destroy-a-page")
  end
end
