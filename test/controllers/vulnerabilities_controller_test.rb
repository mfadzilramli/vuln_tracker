require 'test_helper'

class VulnerabilitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get vulnerabilities_show_url
    assert_response :success
  end

end
