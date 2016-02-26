require 'test_helper'

module Authentication
  class Api::V1::PasswordsControllerTest < ActionController::TestCase
    def setup
      @controller = Authentication::Api::V1::PasswordsController.new
      @routes = Authentication::Engine.routes
      @user = create(:user, password: '123456', auth_token: SecureRandom.base64(64))
      request.headers['api-token'] = @user.auth_token
    end

    # PATCH #create

    test 'PATCH #update changes the password of the user' do
      patch :update, id: @user.id, user: { password: '654321' }, format: :json
      assert_response 204
    end

    test 'PATCH #update returns 403 if there is no current user' do
      request.headers['api-token'] = nil
      patch :update, id: @user.id, user: { password: '654321' }, format: :json
      assert_response 403
    end

    test 'POST #forgot sends an email to reset password' do
      post :forgot, user: { email: @user.email }, format: :json
      assert_response 204
    end

    test 'POST #forgot returns 404 if user not found' do
      post :forgot, user: { email: 'zaza@zizi.com.br' }, format: :json
      assert_response 404
      result = JSON.parse(response.body)
      assert_equal 'not found', result['error']
    end
  end
end
