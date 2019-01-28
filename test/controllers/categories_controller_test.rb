# frozen_string_literal: true

require "test_helper"

# Assure that editors can reorder categories.
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:general)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  def category_params
    {
      name: "Updated Category",
      slug: "updated-category",
      archived: "0"
    }
  end

  test "should get reorder as editor" do
    login(@editor)
    get reorder_categories_url
    assert_response :success
  end

  test "should update order as editor" do
    login(@editor)
    post reorder_categories_url, params: {
      category_ids: [categories(:meeting_minutes).id, categories(:general).id]
    }
    categories(:general).reload
    categories(:meeting_minutes).reload
    assert_equal 0, categories(:meeting_minutes).position
    assert_equal 1, categories(:general).position
    assert_response :success
  end

  test "should get edit as editor" do
    login(@editor)
    get edit_category_url(@category)
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer)
    get edit_category_url(@category)
    assert_redirected_to dashboard_url
  end

  test "should update category as editor" do
    login(@editor)
    patch category_url(@category), params: { category: category_params }
    @category.reload
    assert_redirected_to reorder_categories_url
  end

  test "should not update category as viewer" do
    login(@viewer)
    patch category_url(@category), params: { category: category_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy category" do
    login(@editor)
    assert_difference("Category.count", -1) do
      delete category_url(@category)
    end
    assert_redirected_to reorder_categories_url
  end

  test "should not destroy category as viewer" do
    login(@viewer)
    assert_difference("Category.count", 0) do
      delete category_url(@category)
    end
    assert_redirected_to dashboard_url
  end

  test "should redirect to docs root for docs category" do
    login(@viewer)
    get docs_category_url(@category)
    assert_redirected_to folders_url
  end
end
