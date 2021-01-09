# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 1..User.count do { |u|
#     Book.create name: "Global Book", user: u
# }

u1 = User.create(email: "fran@gmail.com", password: "123")

b1 = Book.create(name: "Global Book", user: u1)