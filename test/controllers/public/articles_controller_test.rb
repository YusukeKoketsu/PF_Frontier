require "test_helper"

class Public::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_articles_show_url
    assert_response :success
  end
end
