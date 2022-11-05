require "test_helper"

class Therapist::ClientRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get therapist_client_records_index_url
    assert_response :success
  end

  test "should get show" do
    get therapist_client_records_show_url
    assert_response :success
  end
end
