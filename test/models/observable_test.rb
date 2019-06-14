require 'test_helper'

class ObservableTest < ActiveSupport::TestCase
  test 'valid observable' do
    observable = Observable.new(
      observable: "192.128.23.2",
      user: users(:user_1),
      ticket: tickets(:ticket_1)
    )
    assert observable.valid?
  end

  test 'invalid observable' do
    observable = Observable.new()

    refute observable.valid?

    assert_equal observable.errors.size, 3
    assert_not_nil observable.errors[:observable], 'no validation error for observable present'
    assert_not_nil observable.errors[:ticket], 'no validation error for ticket present'
    assert_not_nil observable.errors[:user], 'no validation error for user present'
  end
end
