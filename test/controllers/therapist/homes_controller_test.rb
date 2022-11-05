require "test_helper"

class Therapist::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get therapist_homes_top_url
    assert_response :success
  end
end
