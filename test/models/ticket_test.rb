require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test 'valid ticket' do
    ticket = Ticket.new(
       name: "Ticket one",
       status: :open,
       priority: :high,
       user: users(:user_1),
       incident: incidents(:incident_1)
    )
    assert ticket.valid?
  end

  test 'can optionally assign a ticket' do
    ticket = Ticket.new(
       name: "Ticket one",
       status: :open,
       priority: :high,
       user: users(:user_1),
       assigned_to: users(:user_1),
       incident: incidents(:incident_1),
    )
    assert ticket.valid?
  end

  test 'invalid ticket' do
    ticket = Ticket.new()

    refute ticket.valid?

    assert_equal ticket.errors.size, 5
    assert_not_nil ticket.errors[:name], 'no validation error for name present'
    assert_not_nil ticket.errors[:status], 'no validation error for status present'
    assert_not_nil ticket.errors[:priority], 'no validation error for priority present'
    assert_not_nil ticket.errors[:user], 'no validation error for user present'
    assert_not_nil ticket.errors[:incident], 'no validation error for incident present'
  end

  test 'to string' do
    ticket = tickets(:ticket_1)
    assert_equal ticket.to_s, "Ticket One"
  end

  test 'can delete a ticket' do
    # ticket_1 has an comment, an observable, and an attachment
    ticket = tickets(:ticket_1)
    ticket.destroy
    assert ticket.destroyed?
  end
end
