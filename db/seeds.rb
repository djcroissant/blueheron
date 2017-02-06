# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
example_users = %w[admin buyer seller]
example_users.length.times do |n|
  User.create!(first_name:            "Example",
               last_name:             example_users[n].capitalize,
               email:                 "#{example_users[n]}@heron.com",
               password:              "Foobar11",
               password_confirmation: "Foobar11",
               admin:                 example_users[n] == "admin",
               buyer:                 example_users[n] == "buyer",
               seller:                example_users[n] == "seller")
 end

99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "example-#{n+1}@heron.com"
  password = "Foobar11"
  User.create!(first_name:            first_name,
               last_name:             last_name,
               email:                 email,
               password:              password,
               password_confirmation: password,
               buyer:                 n.even?,
               seller:                n.odd?)
end

users = User.order(:created_at).take(40)
listing_name = ["king_salmon", "spot_prawn", "black_cod", "halibut"]
users.each do |user|
  if user.seller
    listing_name.length.times do |n|
      random_quantity = 1 + rand(5000)
      random_price = 1 + rand(20)
      user.listings.create!(name: listing_name[n],
                            quantity: random_quantity,
                            price: random_price,
                            date_caught: Date.yesterday)
    end
  end
end
