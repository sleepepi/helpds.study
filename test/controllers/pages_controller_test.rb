# frozen_string_literal: true

require "test_helper"

# Allow admins to create and update pages.
class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @page = pages(:one)
  end

  def page_params
    {
      name: "Demographics",
      slug: "demographics",
      position: "3",
      archived: "0",
      report_hashes: [
        {
          report_id: reports(:one).id
        },
        {
          report_id: reports(:two).id
        }
      ]
    }
  end

  test "should get index" do
    login(@admin)
    get pages_url
    assert_response :success
  end

  test "should get new" do
    login(@admin)
    get new_page_url
    assert_response :success
  end

  test "should create page" do
    login(@admin)
    assert_difference("Page.count") do
      post pages_url, params: { page: page_params }
    end
    assert_redirected_to page_url(Page.last)
  end

  test "should show page" do
    login(@admin)
    get page_url(@page)
    assert_response :success
  end

  test "should get edit" do
    login(@admin)
    get edit_page_url(@page)
    assert_response :success
  end

  test "should update page" do
    login(@admin)
    patch page_url(@page), params: { page: page_params }
    @page.reload
    assert_redirected_to page_url(@page)
  end

  test "should destroy page" do
    login(@admin)
    assert_difference("Page.count", -1) do
      delete page_url(@page)
    end

    assert_redirected_to pages_url
  end
end
