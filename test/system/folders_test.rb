# frozen_string_literal: true

require "application_system_test_case"

# Test navigating and creating folders.
class FoldersTest < ApplicationSystemTestCase
  setup do
    @category = categories(:general)
    @folder = folders(:mops)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  test "visit docs overview" do
    visit_login(@viewer)
    visit folders_url
    assert_selector "h1", text: "Docs"
    screenshot("visit-docs-overview")
  end

  test "visit folder" do
    visit_login(@viewer)
    visit category_folder_url(@category, @folder)
    assert_selector "h1", text: "Manual of Procedures"
    screenshot("visit-folder")
  end

  test "create a folder" do
    visit_login(@editor)
    visit folders_url
    screenshot("create-a-folder")
    click_on "Add folder"
    fill_in "folder[category]", with: "General"
    fill_in "folder[name]", with: "Procedures"
    fill_in "folder[description]", with: ""
    screenshot("create-a-folder")
    click_on "Create Folder"
    assert_text "Folder was successfully created"
    assert_selector "h1", text: "Procedures"
    screenshot("create-a-folder")
  end

  test "update a folder" do
    visit_login(@editor)
    visit category_folder_url(@category, @folder)
    screenshot("update-a-folder")
    find("i[class='fas fa-cogs']").click
    fill_in "folder[category]", with: "General"
    fill_in "folder[name]", with: "Updated Name"
    fill_in "folder[slug]", with: "updated-name"
    fill_in "folder[description]", with: ""
    screenshot("update-a-folder")
    click_on "Update Folder"
    assert_text "Folder was successfully updated"
    assert_selector "h1", text: "Edit Folders"
    screenshot("update-a-folder")
  end

  test "destroy a folder" do
    skip
    visit_login(@editor)
    visit folders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end
    assert_text "Folder was successfully deleted"
  end
end
