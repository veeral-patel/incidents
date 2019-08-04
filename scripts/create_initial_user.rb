require 'faker'

# To run: rails runner scripts/create_initial_user.rb

password = Faker::Alphanumeric.alpha 15

admin = User.new(username: 'admin', email: 'admin@example.com', password: password, admin: true)
admin.save

puts 'Created user'
puts ''
puts "Username: #{admin}"
puts "Password: #{password}"