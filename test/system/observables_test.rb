require "application_system_test_case"

class ObservablesTest < ApplicationSystemTestCase
  setup do
    @observable = observables(:one)
  end

  test "visiting the index" do
    visit observables_url
    assert_selector "h1", text: "Observables"
  end

  test "creating a Observable" do
    visit observables_url
    click_on "New Observable"

    fill_in "Description", with: @observable.description
    fill_in "Observable", with: @observable.observable
    fill_in "Ticket", with: @observable.ticket_id
    fill_in "User", with: @observable.user_id
    click_on "Create Observable"

    assert_text "Observable was successfully created"
    click_on "Back"
  end

  test "updating a Observable" do
    visit observables_url
    click_on "Edit", match: :first

    fill_in "Description", with: @observable.description
    fill_in "Observable", with: @observable.observable
    fill_in "Ticket", with: @observable.ticket_id
    fill_in "User", with: @observable.user_id
    click_on "Update Observable"

    assert_text "Observable was successfully updated"
    click_on "Back"
  end

  test "destroying a Observable" do
    visit observables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Observable was successfully destroyed"
  end
end
