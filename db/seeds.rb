# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  require 'faker'

  category = Category.create(name: "type A")
  category = Category.create(name: "type B")
  category = Category.create(name: "type C")

  name = Faker::Name.first_name
  10.times do
    user = User.create(email: "#{name}@gmail.com", password: "qwer4321")
  end