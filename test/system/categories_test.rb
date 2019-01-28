# frozen_string_literal: true

require "application_system_test_case"

# Test managing categories.
class CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = categories(:general)
    @editor = users(:editor)
  end

  test "visit reorder categories" do
    visit_login(@editor)
    visit reorder_categories_url
    assert_selector "h1", text: "Edit Folders"
    screenshot("visit-reorder-categories")
  end

  test "update a category" do
    visit_login(@editor)
    visit reorder_categories_url
    screenshot("update-a-category")
    page.all("i[class='fas fa-pencil-alt']")[0].click
    fill_in "category[name]", with: "Updated Name"
    fill_in "category[slug]", with: "updated-name"
    screenshot("update-a-category")
    click_on "Update Category"
    assert_text "Category was successfully updated"
    assert_selector "h1", text: "Edit Folders"
    screenshot("update-a-category")
  end

  test "destroy a category" do
    visit_login(@editor)
    visit reorder_categories_url
    screenshot("destroy-a-category")
    page.accept_confirm do
      page.all("i[class='fas fa-trash']")[0].click
    end
    assert_text "Category was successfully deleted"
    screenshot("destroy-a-category")
  end
end
