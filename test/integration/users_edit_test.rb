require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example_seller)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name: " ",
                                              last_name: " ",
                                              email: "user@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_not flash.nil?
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert_nil session[:forwarding_url]
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name = "Foo"
    last_name = "Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { first_name: first_name,
                                              last_name: last_name,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""} }
    assert_not flash.nil?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.first_name, first_name
    assert_equal @user.last_name, last_name
    assert_equal @user.email, email
  end
end
