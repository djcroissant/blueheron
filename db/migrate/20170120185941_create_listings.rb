class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price
      t.date :date_caught

      t.timestamps
    end
  end
end
