# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:                  "Example User",
             email:                 "example@heron.com",
             password:              "Foobar11",
             password_confirmation: "Foobar11",
             admin:                 true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@heron.com"
  password = "Foobar11"
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
listing_name = ["king_salmon", "spot_prawn", "black_cod", "halibut"]
10.times do
  users.each do |user|
    random_name = listing_name[rand(listing_name.length)]
    random_quantity = 1 + rand(5000)
    random_price = 1 + rand(20)
    user.listings.create!(name: random_name,
                          quantity: random_quantity,
                          price: random_price,
                          date_caught: Date.yesterday)
  end
end
