# frozen_string_literal: true

require "test_helper"

# Tests for friendly forwarding.
class ForwardingTest < ActionDispatch::IntegrationTest
  setup do
    @regular = users(:regular)
    @admin = users(:admin)
  end

  test "should forward to dashboard after login" do
    login(@regular)
    assert_equal dashboard_path, path
  end

  test "should friendly forward to directory" do
    get directory_url
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal directory_path, path
  end

  test "should friendly forward to docs" do
    get folders_url
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal folders_path, path
  end

  test "should friendly forward to search" do
    get search_url(search: "project manager")
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal "project manager", request.params[:search]
    assert_equal search_path, path
  end

  test "should friendly forward to coordinating centers" do
    get coordinating_centers_url
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal coordinating_centers_path, path
  end

  test "should friendly forward to recruiting centers" do
    get recruiting_centers_url
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal recruiting_centers_path, path
  end

  test "should friendly forward to sites index" do
    get sites_url
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal sites_path, path
  end

  test "should friendly forward to site show page" do
    get site_url(sites(:ccc))
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal site_path(sites(:ccc)), path
  end

  test "should friendly forward to folder" do
    @folder = folders(:crfs)
    get category_folder_url(@folder.category, @folder)
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal category_folder_path(@folder.category, @folder), path
  end

  test "should friendly forward to file" do
    @document = documents(:blank_pdf)
    get download_document_url(@document.folder.category, @document.folder, @document.filename)
    assert_redirected_to category_folder_url(@document.folder.category, @document.folder, file: @document.filename)
    follow_redirect!
    assert_redirected_to new_user_session_url
    login(@regular)
    assert_equal @document.filename, request.params[:file]
    assert_equal category_folder_path(@document.folder.category, @document.folder), path
  end

  test "should friendly forward to admin dashboard" do
    get admin_url
    assert_redirected_to new_user_session_url
    login(@admin)
    assert_equal admin_path, path
  end

  test "should friendly forward to admin reorder categories" do
    get reorder_categories_url
    assert_redirected_to new_user_session_url
    login(@admin)
    assert_equal reorder_categories_path, path
  end

  test "should friendly forward to admin edit category" do
    get edit_category_url(categories(:general))
    assert_redirected_to new_user_session_url
    login(@admin)
    assert_equal edit_category_path(categories(:general)), path
  end
end
