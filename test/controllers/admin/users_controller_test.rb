# frozen_string_literal: true

require "test_helper"

# Tests to assure admins can approve users and set user roles.
class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @editor = users(:editor)
    @user = users(:regular)
  end

  def user_params
    {
      full_name: "Full Name",
      username: "username",
      email: "email@example.com",
      approved: "1",
      admin: "1",
      editor: "1",
      phone: "555-123-4567",
      role: "Role",
      key_contact: "0",
      keywords: "nickname",
      staffid: "12-34"
    }
  end

  test "should get index as admin" do
    login(@admin)
    get admin_users_url
    assert_response :success
  end

  test "should not get index as editor" do
    login(@editor)
    get admin_users_url
    assert_redirected_to dashboard_url
  end

  test "should show user as admin" do
    login(@admin)
    get admin_user_url(@user)
    assert_response :success
  end

  test "should not show user as editor" do
    login(@editor)
    get admin_user_url(@user)
    assert_redirected_to dashboard_url
  end

  test "should get edit as admin" do
    login(@admin)
    get edit_admin_user_url(@user)
    assert_response :success
  end

  test "should not get edit as editor" do
    login(@editor)
    get edit_admin_user_url(@user)
    assert_redirected_to dashboard_url
  end

  test "should update user as admin" do
    login(@admin)
    patch admin_user_url(@user), params: { user: user_params }
    @user.reload
    assert_equal "Full Name", @user.full_name
    assert_equal "email@example.com", @user.unconfirmed_email
    assert_equal true, @user.approved
    assert_equal true, @user.admin
    assert_equal true, @user.editor
    assert_equal "555-123-4567", @user.phone
    assert_equal "Role", @user.role
    assert_equal "nickname", @user.keywords
    assert_equal "12-34", @user.staffid
    assert_redirected_to admin_user_url(@user)
  end

  test "should not update user with blank full name as admin" do
    login(@admin)
    patch admin_user_url(@user), params: { user: user_params.merge(full_name: "") }
    assert_response :success
  end

  test "should not update user as editor" do
    login(@editor)
    patch admin_user_url(@user), params: { user: user_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy user as admin" do
    login(@admin)
    assert_difference("User.current.count", -1) do
      delete admin_user_url(@user)
    end
    assert_redirected_to admin_users_url
  end

  test "should not destroy user as editor" do
    login(@editor)
    assert_difference("User.current.count", 0) do
      delete admin_user_url(@user)
    end
    assert_redirected_to dashboard_url
  end
end
