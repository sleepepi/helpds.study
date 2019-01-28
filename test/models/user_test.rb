# frozen_string_literal: true

require "test_helper"

# Test user model validations.
class UserTest < ActiveSupport::TestCase
  test "should only create valid user" do
    user = User.create
    assert_equal ["can't be blank", "must include first and last name"], user.errors[:full_name]
    assert_equal ["can't be blank"], user.errors[:username]
    assert_equal ["can't be blank"], user.errors[:email]
    assert_equal ["can't be blank"], user.errors[:password]
  end
end
