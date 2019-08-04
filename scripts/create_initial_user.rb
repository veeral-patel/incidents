# To run: rails runner scripts/create_initial_user.rb

require 'faker'

# Prompt user for his email address
puts 'Please enter your email address:'
email = gets

username = "admin-#{Faker::Alphanumeric.alpha 5}"
password = Faker::Alphanumeric.alpha 15

admin = User.new(username: username, email: email, password: password, admin: true)

if admin.save
    puts ''
    puts 'Created an admin user'
    puts '----------------------'

    puts "Username: #{admin.username}"
    puts "Email: #{admin.email}"
    puts "Password: #{password}"

    puts ''
    puts 'If you mis-typed your email address or username, no worries -- you can change them after you log in!'
else
    puts 'Failed to create initial user'
end