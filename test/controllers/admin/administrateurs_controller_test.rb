require 'test_helper'

class Admin::AdministrateursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_administrateurs_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_administrateurs_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_administrateurs_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_administrateurs_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_administrateurs_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_administrateurs_update_url
    assert_response :success
  end

  test "should get connect" do
    get admin_administrateurs_connect_url
    assert_response :success
  end

end
