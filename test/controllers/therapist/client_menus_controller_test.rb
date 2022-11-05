require "test_helper"

class Therapist::ClientMenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get therapist_client_menus_index_url
    assert_response :success
  end

  test "should get new" do
    get therapist_client_menus_new_url
    assert_response :success
  end

  test "should get edit" do
    get therapist_client_menus_edit_url
    assert_response :success
  end
end
