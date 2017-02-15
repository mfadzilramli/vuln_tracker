require 'test_helper'

class ProjectGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_group = project_groups(:one)
  end

  test "should get index" do
    get project_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_project_group_url
    assert_response :success
  end

  test "should create project_group" do
    assert_difference('ProjectGroup.count') do
      post project_groups_url, params: { project_group: {  } }
    end

    assert_redirected_to project_group_url(ProjectGroup.last)
  end

  test "should show project_group" do
    get project_group_url(@project_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_group_url(@project_group)
    assert_response :success
  end

  test "should update project_group" do
    patch project_group_url(@project_group), params: { project_group: {  } }
    assert_redirected_to project_group_url(@project_group)
  end

  test "should destroy project_group" do
    assert_difference('ProjectGroup.count', -1) do
      delete project_group_url(@project_group)
    end

    assert_redirected_to project_groups_url
  end
end
