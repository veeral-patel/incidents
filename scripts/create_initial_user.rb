# To run: rails runner scripts/create_initial_user.rb

require 'faker'

username = "admin-#{Faker::Alphanumeric.alpha 5}"
password = Faker::Alphanumeric.alpha 15

admin = User.new(username: username, email: 'admin@example.com', password: password, admin: true)

if admin.save
    puts ''
    puts 'Created an admin user'
    puts '----------------------'

    puts "Username: #{admin.username}"
    puts "Password: #{password}"

    puts ''
    puts 'Now visit http://localhost:80 to log in!'
else
    puts 'Failed to create initial user'
end
