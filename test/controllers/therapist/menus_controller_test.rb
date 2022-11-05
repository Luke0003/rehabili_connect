require "test_helper"

class Therapist::MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get therapist_menus_index_url
    assert_response :success
  end

  test "should get new" do
    get therapist_menus_new_url
    assert_response :success
  end

  test "should get show" do
    get therapist_menus_show_url
    assert_response :success
  end

  test "should get edit" do
    get therapist_menus_edit_url
    assert_response :success
  end
end
