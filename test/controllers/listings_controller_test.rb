require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  def setup
    @base_title = "Blue Heron Marketplace"
    @user = users(:example)
    @other_user = users(:old_greg)
    @listing = listings(:king_salmon)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "My Catch | #{@base_title}"
  end

  test "should redirect edit when not logged in" do
    get :edit, params: { id: @user }
    assert_not flash.nil?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, params: { id: @user, user: { name: @user.name, email: @user.email } }
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
    patch :update, params:{ id: @user, user: { name: @user.name, email: @user.email } }
    assert_not flash.nil?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Listing.count' do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to login_url
  end


end
