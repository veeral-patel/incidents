# create 5 users
5.times do
    User.create(
       username: Faker::Internet.unique.username,
       email: Faker::Internet.unique.email,
       password: Faker::Internet.password
    )
end

# create 5 incidents
5.times do
    random_user = User.all.sample
    random_user.incidents.create(
        name: "Incident-#{Faker::Code.nric}",
        status: [:open, :closed, :in_progress].sample,
    )
end

# create 25 tickets
25.times do
    random_user = User.all.sample
    random_user.tickets.create(
        name: "Ticket-#{Faker::Code.nric}",
        incident: Incident.all.sample,
        status: [:open, :closed, :in_progress].sample,
        priority: [:high, :medium, :low].sample,
    )
end

puts "Seeded the database"