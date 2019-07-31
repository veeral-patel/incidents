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
    is_lead = (rand <= 0.3) # 30% chance it's a lead

    random_user.tickets.create(
        name: "Ticket-#{Faker::Code.nric}",
        incident: Incident.all.sample,
        status: [:open, :closed, :in_progress].sample,
        priority: [:high, :medium, :low].sample,
        is_lead: is_lead
    )
end

# create 75 observables
75.times do
    random_user = User.all.sample
    random_observable = [
        Faker::Internet.domain_name,
        Faker::Internet.ip_v4_address,
        Faker::Internet.ip_v6_address,
        Faker::Internet.url
    ].sample

    random_user.observables.create(
        observable: random_observable,
        ticket: Ticket.all.sample
    )
end

# create 150 comments
150.times do
    random_user = User.all.sample
    random_comment = [
        Faker::Quote.famous_last_words,
        Faker::Quote.matz,
        Faker::Quote.most_interesting_man_in_the_world,
        Faker::Quote.yoda
    ].sample

    random_user.comments.create(
        comment: random_comment,
        ticket: Ticket.all.sample
    )
end

puts "Seeded the database"