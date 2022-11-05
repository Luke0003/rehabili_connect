require "test_helper"

class Public::ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_clients_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_clients_edit_url
    assert_response :success
  end
end
