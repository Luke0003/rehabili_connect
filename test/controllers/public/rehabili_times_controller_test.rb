require "test_helper"

class Public::RehabiliTimesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_rehabili_times_new_url
    assert_response :success
  end

  test "should get create" do
    get public_rehabili_times_create_url
    assert_response :success
  end
end
