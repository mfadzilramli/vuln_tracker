require 'test_helper'

class AffectedHostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get affected_hosts_index_url
    assert_response :success
  end

  test "should get show" do
    get affected_hosts_show_url
    assert_response :success
  end

  test "should get create" do
    get affected_hosts_create_url
    assert_response :success
  end

  test "should get edit" do
    get affected_hosts_edit_url
    assert_response :success
  end

  test "should get update" do
    get affected_hosts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get affected_hosts_destroy_url
    assert_response :success
  end

end
