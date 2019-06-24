require "application_system_test_case"

class TicketTemplatesTest < ApplicationSystemTestCase
  setup do
    @ticket_template = ticket_templates(:one)
  end

  test "visiting the index" do
    visit ticket_templates_url
    assert_selector "h1", text: "Ticket Templates"
  end

  test "creating a Ticket template" do
    visit ticket_templates_url
    click_on "New Ticket Template"

    fill_in "Description", with: @ticket_template.description
    fill_in "Name", with: @ticket_template.name
    click_on "Create Ticket template"

    assert_text "Ticket template was successfully created"
    click_on "Back"
  end

  test "updating a Ticket template" do
    visit ticket_templates_url
    click_on "Edit", match: :first

    fill_in "Description", with: @ticket_template.description
    fill_in "Name", with: @ticket_template.name
    click_on "Update Ticket template"

    assert_text "Ticket template was successfully updated"
    click_on "Back"
  end

  test "destroying a Ticket template" do
    visit ticket_templates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ticket template was successfully destroyed"
  end
end
