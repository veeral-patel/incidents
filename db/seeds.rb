1.times do
    user = User.create(
       username: Faker::Internet.unique.username,
       email: Faker::Internet.unique.email,
       password: Faker::Internet.password
    )

    incident = user.incidents.create(
        name: "Incident-#{Faker::Code.nric}",
        status: [:open, :closed, :in_progress].sample,
        user: user
    )
end

puts "Seeded the database"