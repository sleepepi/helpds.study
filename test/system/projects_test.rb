# frozen_string_literal: true

require "application_system_test_case"

# Test for admins to view projects.
class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
    @admin = users(:admin)
  end

  test "visit the index" do
    visit_login(@admin)
    visit projects_url
    assert_selector "h1", text: "Projects"
    screenshot("visit-projects-index")
  end

  test "create a project" do
    visit_login(@admin)
    visit projects_url
    screenshot("create-a-project")
    click_on "New project"
    fill_in "project[name]", with: "Project One"
    fill_in "project[access_token]", with: "1234567890"
    screenshot("create-a-project")
    click_on "Create Project"
    assert_text "Project was successfully created"
    assert_selector "h1", text: "Projects"
    screenshot("create-a-project")
  end

  test "update a project" do
    visit_login(@admin)
    visit projects_url
    screenshot("update-a-project")
    click_on "Actions", match: :first
    screenshot("update-a-project")
    click_on "Edit"
    fill_in "project[name]", with: "Updated Name"
    screenshot("update-a-project")
    click_on "Update Project"
    assert_text "Project was successfully updated"
    assert_selector "h1", text: "Projects"
    screenshot("update-a-project")
  end

  test "destroy a project" do
    visit_login(@admin)
    visit projects_url
    screenshot("destroy-a-project")
    click_on "Actions", match: :first
    page.accept_confirm do
      click_on "Delete"
    end
    assert_text "Project was successfully deleted"
    screenshot("destroy-a-project")
  end
end
