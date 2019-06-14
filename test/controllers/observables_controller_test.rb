require 'test_helper'

class ObservablesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @observable = observables(:observable_1)
    @user = users(:user_1)
    sign_in @user
  end

  test "should get index" do
    get ticket_observables_url(@observable.ticket)
    assert_response :success
  end

  test "should get new" do
    get new_ticket_observable_url(@observable.ticket)
    assert_response :success
  end

  test "should create observable" do
    assert_difference('Observable.count') do
    post ticket_observables_url(@observable.ticket), params: { observable: { description: @observable.description, observable: @observable.observable, ticket_id: @observable.ticket_id, user_id: @observable.user_id } }
    end

    assert_redirected_to ticket_observable_url(Observable.last.ticket, Observable.last)
  end

  test "should show observable" do
    get ticket_observable_url(@observable.ticket, @observable)
    assert_response :success
  end

  test "should update observable" do
      patch ticket_observable_url(@observable.ticket, @observable), params: { observable: { description: @observable.description, observable: @observable.observable, ticket_id: @observable.ticket_id, user_id: @observable.user_id } }
      assert_redirected_to ticket_observable_url(@observable.ticket,@observable)
  end

  test "should destroy observable" do
    assert_difference('Observable.count', -1) do
      delete ticket_observable_url(@observable.ticket, @observable)
    end

    assert_redirected_to ticket_observables_url(@observable.ticket)
  end
end
