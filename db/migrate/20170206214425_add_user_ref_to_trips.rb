class AddUserRefToTrips < ActiveRecord::Migration[5.0]
  def change
    add_reference :trips, :user, foreign_key: true
    remove_reference :listings, :user
    add_reference :listings, :trip
  end
end
