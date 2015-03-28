# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Budget.destroy_all

9.times do |i|
  User.create(first_name:"Jim#{i}", last_name:"Rhode#{i}", birthday: '1980-09-01', email:"jrhode#{i}@test.com", cell_num:"000000001#{i}", password:"testusers")
end

9.times do |i|
  Budget.create(name: "Jim#{i}'s' Budget", user_id: i+1)
end
7.times do |i|
  Month.create(name: "Jim#{i}'s First", budget_id: i+1, month_date: '2015-03-01', projected_income:0.00, projected_exp:0, actual_income:0, actual_exp:0)
end