require 'test_helper'

class TicketTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket_template = ticket_templates(:one)
  end

  test "should get index" do
    get ticket_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_template_url
    assert_response :success
  end

  test "should create ticket_template" do
    assert_difference('TicketTemplate.count') do
      post ticket_templates_url, params: { ticket_template: { description: @ticket_template.description, name: @ticket_template.name } }
    end

    assert_redirected_to ticket_template_url(TicketTemplate.last)
  end

  test "should show ticket_template" do
    get ticket_template_url(@ticket_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_template_url(@ticket_template)
    assert_response :success
  end

  test "should update ticket_template" do
    patch ticket_template_url(@ticket_template), params: { ticket_template: { description: @ticket_template.description, name: @ticket_template.name } }
    assert_redirected_to ticket_template_url(@ticket_template)
  end

  test "should destroy ticket_template" do
    assert_difference('TicketTemplate.count', -1) do
      delete ticket_template_url(@ticket_template)
    end

    assert_redirected_to ticket_templates_url
  end
end
