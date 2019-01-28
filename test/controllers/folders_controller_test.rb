# frozen_string_literal: true

require "test_helper"

# Tests to assure users can view folders, and editors can manage files and
# folders.
class FoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:general)
    @folder = folders(:mops)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  def folder_params
    {
      category: "General",
      name: "New Folder",
      slug: "new-folder",
      description: "This is a newly created folder with no files.",
      archived: "0"
    }
  end

  test "should get index as editor" do
    login(@editor)
    get folders_url
    assert_response :success
  end

  test "should get index as viewer" do
    login(@viewer)
    get folders_url
    assert_response :success
  end

  test "should not get index as public user" do
    get folders_url
    assert_redirected_to new_user_session_url
  end

  test "should get new as editor" do
    login(@editor)
    get new_folder_url
    assert_response :success
  end

  test "should not get new as viewer" do
    login(@viewer)
    get new_folder_url
    assert_redirected_to dashboard_url
  end

  test "should create folder as editor" do
    login(@editor)
    assert_difference("Folder.count") do
      post folders_url, params: { folder: folder_params }
    end
    assert_redirected_to category_folder_url(categories(:general), Folder.last)
  end

  test "should not create folder as viewer" do
    login(@viewer)
    assert_difference("Folder.count", 0) do
      post folders_url, params: { folder: folder_params }
    end
    assert_redirected_to dashboard_url
  end

  test "should show folder as editor" do
    login(@editor)
    get category_folder_url(@category, @folder)
    assert_response :success
  end

  test "should show folder as viewer" do
    login(@viewer)
    get category_folder_url(@category, @folder)
    assert_response :success
  end

  test "should not show folder as public user" do
    get category_folder_url(@category, @folder)
    assert_redirected_to new_user_session_url
  end

  test "should get edit as editor" do
    login(@editor)
    get edit_category_folder_url(@category, @folder)
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer)
    get edit_category_folder_url(@category, @folder)
    assert_redirected_to dashboard_url
  end

  test "should update folder as editor" do
    login(@editor)
    patch folder_url(@folder.id), params: { folder: folder_params }
    @folder.reload
    assert_redirected_to reorder_categories_url
  end

  test "should not update folder as viewer" do
    login(@viewer)
    patch folder_url(@folder.id), params: { folder: folder_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy folder" do
    login(@editor)
    assert_difference("Folder.count", -1) do
      delete folder_url(@folder.id)
    end
    assert_redirected_to reorder_categories_url
  end

  test "should not destroy folder as viewer" do
    login(@viewer)
    assert_difference("Folder.count", 0) do
      delete folder_url(@folder.id)
    end
    assert_redirected_to dashboard_url
  end

  test "should get upload as editor" do
    login(@editor)
    get upload_category_folder_url(@category, @folder)
    assert_response :success
  end

  test "should attach file as editor" do
    login(@editor)
    assert_difference("Document.count", 1) do
      post attach_file_folder_url(@folder.id), params: {
        file: fixture_file_upload(file_fixture("rails.png"))
      }
    end
    assert_redirected_to category_folder_url(@category, @folder, order: "latest")
  end

  test "should not attach empty file as editor" do
    login(@editor)
    assert_difference("Document.count", 0) do
      post attach_file_folder_url(@folder.id), params: { file: "" }
    end
    assert_redirected_to upload_category_folder_url(@category, @folder)
  end

  test "should attach files as editor" do
    login(@editor)
    assert_difference("Document.count", 2) do
      post attach_files_folder_url(@folder.id, format: "js"), params: {
        files: [
          fixture_file_upload(file_fixture("blank.pdf")),
          fixture_file_upload(file_fixture("rails.png"))
        ]
      }
    end
    assert_response :success
  end

  test "should attach duplicate files only once as editor" do
    login(@editor)
    assert_difference("Document.count", 1) do
      post attach_files_folder_url(@folder.id, format: "js"), params: {
        files: [
          fixture_file_upload(file_fixture("rails.png")),
          fixture_file_upload(file_fixture("rails.png"))
        ]
      }
    end
    assert_response :success
  end
end
