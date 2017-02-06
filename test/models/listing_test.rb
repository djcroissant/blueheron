require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  def setup
    @user = users(:example_seller)
    @listing = @user.listings.build(name: "King Salmon", quantity: 200,
                           price: 13.50, date_caught: Date.today)
  end

  test "should be valid" do
    assert @listing.valid?
  end

  test "name should be present" do
    @listing.name = "   "
    assert_not @listing.valid?
  end

  test "quantity should be greater than zero" do
    @listing.quantity = 0
    assert_not @listing.valid?
  end

  test "price should be greater than zero" do
    @listing.price = 0
    assert_not @listing.valid?
  end

  test "date caught should be today or earlier" do
    @listing.date_caught = Date.tomorrow
    assert_not @listing.valid?
  end

  test "listing must be assigned to user" do
    @listing.user = nil
    assert_not @listing.valid?
  end
end
