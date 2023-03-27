require "test_helper"

class BiddersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bidders_new_url
    assert_response :success
  end
end
