require 'test_helper'

class ArticleControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get article_show_url
    assert_response :success
  end

  test "should get create" do
    get article_create_url
    assert_response :success
  end

end
