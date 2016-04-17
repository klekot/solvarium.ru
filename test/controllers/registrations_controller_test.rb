require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "should get sign_up_params" do
    get :sign_up_params
    assert_response :success
  end

  test "should get account_update_params" do
    get :account_update_params
    assert_response :success
  end

end
