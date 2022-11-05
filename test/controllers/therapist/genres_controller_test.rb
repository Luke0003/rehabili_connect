require "test_helper"

class Therapist::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get therapist_genres_index_url
    assert_response :success
  end

  test "should get edit" do
    get therapist_genres_edit_url
    assert_response :success
  end
end
