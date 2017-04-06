require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get reports_generate_url
    assert_response :success
  end

end
