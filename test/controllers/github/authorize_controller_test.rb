require 'test_helper'

class Github::AuthorizeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get github_authorize_new_url
    assert_response :success
  end

  test "should get callback" do
    get github_authorize_callback_url
    assert_response :success
  end

  test "should get access_token" do
    get github_authorize_access_token_url
    assert_response :success
  end

end
