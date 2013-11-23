# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
password = 'aaaa'
user.email = 'a@a.com'
user.password = password
user.password_confirmation = password
if user.save
  puts "== User created with email #{user.email} and password #{password}"
else
  puts "== ERROR :: User can't created with email #{user.email} and password #{password}"
end
