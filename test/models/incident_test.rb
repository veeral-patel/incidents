require 'test_helper'

class IncidentTest < ActiveSupport::TestCase
  test 'valid incident' do
    creator = users(:user_1)

    # status can also be a number (0-2) or "open"/"closed"/"in_progress"
    incident = Incident.new(name: "An incident", status: :in_progress, user: creator)

    assert incident.valid?
  end

  test 'invalid incident' do
    incident = Incident.new()

    refute incident.valid?

    assert_equal incident.errors.size, 3
    assert_not_nil incident.errors[:name], 'no validation error for name present'
    assert_not_nil incident.errors[:status], 'no validation error for status present'
    assert_not_nil incident.errors[:user], 'no validation error for user present'
  end

  test 'get leads' do
    incident = incidents(:incident_1)
    assert_equal incident.leads.count, 1
    assert_equal incident.leads.first.id, 2
  end

  test 'get open tickets' do
    incident = incidents(:incident_1)
    assert_equal incident.open_tickets.count, 1
    assert_equal incident.open_tickets.first.id, 1
  end

  test 'get in progress tickets' do
    incident = incidents(:incident_1)
    assert_equal incident.in_progress_tickets.count, 0
  end

  test 'get closed tickets' do
    incident = incidents(:incident_1)
    assert_equal incident.closed_tickets.count, 1
    assert_equal incident.closed_tickets.first.id, 2
  end

  test 'to string' do
    incident = incidents(:incident_1)
    assert_equal incident.to_s, "Incident One"
  end

  test 'to json -- one level' do
    # incident_1 has two tickets, both at one level
    # below the root
    incident = incidents(:incident_1)
    assert_equal incident.to_json, {
      text: { name: "root" },
      collapsable: true,
      children: [
        {
          text: { name: "Ticket One" },
          link: { href: "/tickets/1" },
          collapsable: true,
          HTMLclass: "open",
          HTMLid: 1
        },
        {
          text: { name: "Ticket Two [lead]" },
          link: { href: "/tickets/2" },
          collapsable: true,
          HTMLclass: "closed",
          HTMLid: 2
        }
      ]
    }
  end

  test 'to json -- no tickets' do
    # incident_2 has no tickets
    incident = incidents(:incident_2)
    assert_equal incident.to_json, {
      text: { name: "root" },
      collapsable: true,
      children: []
    }
  end
end
