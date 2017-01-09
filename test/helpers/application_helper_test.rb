require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Blue Heron Marketplace"
    assert_equal full_title("Contact"), "Contact | Blue Heron Marketplace"
  end
end
