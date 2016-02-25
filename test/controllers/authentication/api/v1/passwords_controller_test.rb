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
  end
end
