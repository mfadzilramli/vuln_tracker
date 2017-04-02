require 'test_helper'

class ReportFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report_file = report_files(:one)
  end

  test "should get index" do
    get report_files_url
    assert_response :success
  end

  test "should get new" do
    get new_report_file_url
    assert_response :success
  end

  test "should create report_file" do
    assert_difference('ReportFile.count') do
      post report_files_url, params: { report_file: {  } }
    end

    assert_redirected_to report_file_url(ReportFile.last)
  end

  test "should show report_file" do
    get report_file_url(@report_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_file_url(@report_file)
    assert_response :success
  end

  test "should update report_file" do
    patch report_file_url(@report_file), params: { report_file: {  } }
    assert_redirected_to report_file_url(@report_file)
  end

  test "should destroy report_file" do
    assert_difference('ReportFile.count', -1) do
      delete report_file_url(@report_file)
    end

    assert_redirected_to report_files_url
  end
end
