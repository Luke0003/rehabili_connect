require "test_helper"

class Therapist::ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get therapist_clients_show_url
    assert_response :success
  end
end
