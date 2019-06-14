require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(username: 'rob', email: 'rob@example.com', password: 'robisgreat!!')
    assert user.valid?
  end

  test 'invalid user' do
    user = User.new()
    assert_not_nil user.errors[:username], 'no validation error for username present'
    assert_not_nil user.errors[:password], 'no validation error for password present'
    assert_not_nil user.errors[:email], 'no validation error for email present'
  end

  test 'usernames must be unique' do
    user1 = User.new(username: 'rob', email: 'rob1@example.com', password: 'rob1isgreat!!')
    user1.save

    user2 = User.new(username: 'rob', email: 'rob1@example.com', password: 'rob2isgreat!!')

    refute user2.valid?
  end

  test 'emails must be unique' do
    user1 = User.new(username: 'rob1', email: 'rob@example.com', password: 'rob1isgreat!!')
    user1.save

    user2 = User.new(username: 'rob2', email: 'rob@example.com', password: 'rob2isgreat!!')

    refute user2.valid?
  end

  test 'to string' do
    user = users(:user_1)
    assert user.username, "test"
  end
end
