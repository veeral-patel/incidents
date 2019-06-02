require 'test_helper'

class ObservablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @observable = observables(:one)
  end

  test "should get index" do
    get observables_url
    assert_response :success
  end

  test "should get new" do
    get new_observable_url
    assert_response :success
  end

  test "should create observable" do
    assert_difference('Observable.count') do
      post observables_url, params: { observable: { description: @observable.description, observable: @observable.observable, ticket_id: @observable.ticket_id, user_id: @observable.user_id } }
    end

    assert_redirected_to observable_url(Observable.last)
  end

  test "should show observable" do
    get observable_url(@observable)
    assert_response :success
  end

  test "should get edit" do
    get edit_observable_url(@observable)
    assert_response :success
  end

  test "should update observable" do
    patch observable_url(@observable), params: { observable: { description: @observable.description, observable: @observable.observable, ticket_id: @observable.ticket_id, user_id: @observable.user_id } }
    assert_redirected_to observable_url(@observable)
  end

  test "should destroy observable" do
    assert_difference('Observable.count', -1) do
      delete observable_url(@observable)
    end

    assert_redirected_to observables_url
  end
end
