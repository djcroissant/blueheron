class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :port_city
      t.string :port_state
      t.datetime :port_date

      t.timestamps
    end
  end
end
