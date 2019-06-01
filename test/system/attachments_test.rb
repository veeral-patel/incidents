require "application_system_test_case"

class AttachmentsTest < ApplicationSystemTestCase
  setup do
    @attachment = attachments(:one)
  end

  test "visiting the index" do
    visit attachments_url
    assert_selector "h1", text: "Attachments"
  end

  test "creating a Attachment" do
    visit attachments_url
    click_on "New Attachment"

    fill_in "Description", with: @attachment.description
    click_on "Create Attachment"

    assert_text "Attachment was successfully created"
    click_on "Back"
  end

  test "updating a Attachment" do
    visit attachments_url
    click_on "Edit", match: :first

    fill_in "Description", with: @attachment.description
    click_on "Update Attachment"

    assert_text "Attachment was successfully updated"
    click_on "Back"
  end

  test "destroying a Attachment" do
    visit attachments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Attachment was successfully destroyed"
  end
end
