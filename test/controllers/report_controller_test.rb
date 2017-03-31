require 'test_helper'

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get report_generate_url
    assert_response :success
  end

end
