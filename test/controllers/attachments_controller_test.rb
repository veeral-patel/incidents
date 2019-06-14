require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @attachment = attachments(:attachment_1)
    @user = users(:user_1)
    sign_in @user
  end

  test "should get index" do
    get ticket_attachments_url(@attachment.ticket)
    assert_response :success
  end

  test "should get new" do
    get new_ticket_attachment_url(@attachment.ticket, @attachment)
    assert_response :success
  end

  test "should create attachment" do
    assert_difference('Attachment.count') do
        post ticket_attachments_url(@attachment.ticket), params: { attachment: { description: @attachment.description, ticket_id: @attachment.ticket_id } }
    end

    assert_redirected_to ticket_attachment_url(Attachment.last.ticket, Attachment.last)
  end

  test "should show attachment" do
    get ticket_attachment_url(@attachment.ticket, @attachment.ticket)
    assert_response :success
  end

  test "should update attachment" do
     patch ticket_attachment_url(@attachment.ticket, @attachment), params: { attachment: { description: @attachment.description } }
    assert_redirected_to ticket_attachment_url(@attachment)
  end

  test "should destroy attachment" do
    assert_difference('Attachment.count', -1) do
        delete ticket_attachment_url(@attachment.ticket, @attachment)
    end

    assert_redirected_to ticket_attachments_url(@attachment.ticket)
  end
end
