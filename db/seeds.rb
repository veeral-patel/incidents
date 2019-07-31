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
        tag_list: [Faker::Ancient.unique.god] * rand(1..4)
    )
    Faker::Ancient.unique.clear
end

# create 50 tickets
50.times do
    random_user = User.all.sample
    random_incident = Incident.all.sample

     # 30% chance the ticket's a lead
    is_lead = (rand <= 0.3)

    # 70% chance the ticket is assigned to an user
    is_assigned = (rand <= 0.7)

    # 80% chance the ticket has a parent ticket
    has_parent = (rand <= 0.8)

    random_user.tickets.create(
        name: "Ticket-#{Faker::Code.nric}",
        incident: random_incident,
        status: [:open, :closed, :in_progress].sample,
        priority: [:high, :medium, :low].sample,
        is_lead: is_lead,
        assigned_to: is_assigned ? User.all.sample : nil,
        parent: has_parent ? random_incident.tickets.sample : nil,
        tag_list: [Faker::Ancient.unique.god] * rand(1..4)
    )
    Faker::Ancient.unique.clear
end

# create 150 observables
150.times do
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

# create 200 comments
200.times do
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
