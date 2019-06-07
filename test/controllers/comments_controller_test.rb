require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @comment = comments(:comment_1)
    @user = users(:user_1)
    sign_in @user
  end

  test "should get index" do
    get ticket_comments_url(@comment.ticket)
    assert_response :success
  end

  test "should get new" do
    get new_ticket_comment_url(@comment.ticket)
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
        post ticket_comments_url(@comment.ticket), params: { comment: { comment: @comment.comment, user: @comment.user, ticket: @comment.ticket } }
    end

    assert_redirected_to ticket_comment_url(Comment.last.ticket, Comment.last)
  end

  test "should show comment" do
    get ticket_comment_url(@comment.ticket, @comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_comment_url(@comment.ticket, @comment)
    assert_response :success
  end

  test "should update comment" do
    patch ticket_comment_url(@comment.ticket, @comment), params: { comment: { comment: @comment.comment, user_id: @comment.user_id } }
    assert_redirected_to ticket_comment_url(@comment.ticket, @comment)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
     delete ticket_comment_url(@comment.ticket, @comment)
    end

    assert_redirected_to ticket_comments_url(@comment.ticket)
  end
end


