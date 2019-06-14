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
end
