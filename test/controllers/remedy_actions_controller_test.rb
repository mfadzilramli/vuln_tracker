require 'test_helper'

class RemedyActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @remedy_action = remedy_actions(:one)
  end

  test "should get index" do
    get remedy_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_remedy_action_url
    assert_response :success
  end

  test "should create remedy_action" do
    assert_difference('RemedyAction.count') do
      post remedy_actions_url, params: { remedy_action: {  } }
    end

    assert_redirected_to remedy_action_url(RemedyAction.last)
  end

  test "should show remedy_action" do
    get remedy_action_url(@remedy_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_remedy_action_url(@remedy_action)
    assert_response :success
  end

  test "should update remedy_action" do
    patch remedy_action_url(@remedy_action), params: { remedy_action: {  } }
    assert_redirected_to remedy_action_url(@remedy_action)
  end

  test "should destroy remedy_action" do
    assert_difference('RemedyAction.count', -1) do
      delete remedy_action_url(@remedy_action)
    end

    assert_redirected_to remedy_actions_url
  end
end
