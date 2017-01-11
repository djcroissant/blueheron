require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @base_title = "Blue Heron Marketplace"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Log in | #{@base_title}"
  end

end
