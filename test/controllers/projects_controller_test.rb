# frozen_string_literal: true

require "test_helper"

# Allow admins to create and update projects.
class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @project = projects(:one)
  end

  def project_params
    {
      name: @project.name,
      access_token: "1-234567890"
    }
  end

  test "should get index" do
    login(@admin)
    get projects_url
    assert_response :success
  end

  test "should get new" do
    login(@admin)
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    login(@admin)
    assert_difference("Project.count") do
      post projects_url, params: { project: project_params }
    end
    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    login(@admin)
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    login(@admin)
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    login(@admin)
    patch project_url(@project), params: { project: project_params }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project" do
    login(@admin)
    assert_difference("Project.count", -1) do
      delete project_url(@project)
    end
    assert_redirected_to projects_url
  end
end
