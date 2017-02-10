require 'test_helper'

class TripTest < ActiveSupport::TestCase
  def setup
    @user = users(:example_seller)
    @trip = @user.trips.build(port_city: "Homer", port_state: "AK",
                              port_date: Date.tomorrow)
  end

  test "should be valid" do
    assert @trip.valid?
  end

  test "port_city should be present" do
    @trip.port_city = "   "
    assert_not @trip.valid?
  end

  test "port_state should be present" do
    @trip.port_state = "   "
    assert_not @trip.valid?
  end

  test "port_date should be tomorrow or later" do
    @trip.port_date = Date.today
    assert_not @trip.valid?
  end

  test "trip must be assigned to user" do
    @trip.user = nil
    assert_not @trip.valid?
  end

  test "associated listings should be destroyed" do
    @trip.save
    @trip.listings.create!(name: "King Salmon", quantity: 200,
                           price: 13.50, date_caught: Date.today)
    assert_difference 'Listing.count', -1 do
      @trip.destroy
    end
  end
end
