require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid sign up information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name: " ",
                                         last_name: " ",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_not flash.nil?
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name: "Example",
                                         last_name: "User",
                                         email: "val@id.com",
                                         password: "Foobar22",
                                         password_confirmation: "Foobar22"} }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
    assert is_logged_in?
  end
end
