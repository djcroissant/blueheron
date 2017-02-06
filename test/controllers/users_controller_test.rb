require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @base_title = "Blue Heron Marketplace"
    @user = users(:example_seller)
    @other_user = users(:old_greg)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | #{@base_title}"
  end

  test "should redirect edit when not logged in" do
    get :edit, params: { id: @user }
    assert_not flash.nil?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, params: { id: @user, user: { first_name: @user.first_name,
                                                last_name: @user.last_name,
                                                email: @user.email } }
    assert_not flash.nil?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, params: { id: @user }
    assert_not flash.nil?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, params:{ id: @user, user: { first_name: @user.first_name,
                                                last_name: @user.last_name,
                                                email: @user.email } }
    assert_not flash.nil?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to root_url
  end

  test "should not allow admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, params: { id: @other_user,
                            user: { password: 'Newpassword11',
                                    password_confirmation: 'Newpassword11',
                                    admin: true } }
    assert_not @other_user.reload.admin?
  end
end
