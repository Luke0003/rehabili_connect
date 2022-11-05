require "test_helper"

class Public::ClientRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_client_records_index_url
    assert_response :success
  end

  test "should get show" do
    get public_client_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_client_records_edit_url
    assert_response :success
  end

  test "should get new" do
    get public_client_records_new_url
    assert_response :success
  end
end
