require 'test_helper'

class AlertesControllerTest < ActionDispatch::IntegrationTest
  test "should get msginfosdemandepret" do
    get alertes_msginfosdemandepret_url
    assert_response :success
  end

end
