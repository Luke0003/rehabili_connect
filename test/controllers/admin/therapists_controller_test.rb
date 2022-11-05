require "test_helper"

class Admin::TherapistsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_therapists_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_therapists_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_therapists_edit_url
    assert_response :success
  end
end
