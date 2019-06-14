require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'valid comment' do
    comment = Comment.new(
      comment: "Hello",
      user: users(:user_1),
      ticket: tickets(:ticket_1)
    )

    assert comment.valid?
  end

  test 'empty comments are invalid' do
    comment = Comment.new(
      comment: "",
      user: users(:user_1),
      ticket: tickets(:ticket_1)
    )

    refute comment.valid?
  end

  test 'invalid comment' do
    comment = Comment.new()

    refute comment.valid?

    assert_equal comment.errors.size, 3
    assert_not_nil comment.errors[:comment], 'no validation error for comment present'
    assert_not_nil comment.errors[:ticket], 'no validation error for ticket present'
    assert_not_nil comment.errors[:user], 'no validation error for user present'
  end
end
