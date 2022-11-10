require "test_helper"

class Therapist::ChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get therapist_chats_show_url
    assert_response :success
  end
end
