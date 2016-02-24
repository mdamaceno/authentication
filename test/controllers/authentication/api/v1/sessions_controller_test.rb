require 'test_helper'

module Authentication
  class Api::V1::SessionsControllerTest < ActionController::TestCase
    def setup
      @controller = Authentication::Api::V1::SessionsController.new
      @routes = Authentication::Engine.routes
    end

    # POST #create

    test '#POST #create generates a token for the user' do
      user = create(:user, email: 'email@example.com', password: '123456')
      assert_nil user.auth_token
      params = { user: { email: user.email, password: user.password } }
      post :create, params, format: :json
      result = JSON.parse(response.body)
      assert_not_nil result['auth_token']
      assert_equal response.headers['api-key'], result['auth_token']
    end

    test '#POST #create does not generate a token for the user if wrong credentials are submitted' do
      user = create(:user, email: 'email@example.com', password: '123456')
      assert_nil user.auth_token
      params = { user: { email: user.email, password: '654321' } }
      post :create, params, format: :json
      result = JSON.parse(response.body)
      assert_equal 'Nothing to do', result['error']
      assert_response :not_found
    end

    # DELETE #destroy

    test '#DELETE #destroy removes the token of the user' do
      user = create(:user, email: 'email@example.com', password: '123456', auth_token: SecureRandom.base64(64))
      assert_not_nil user.auth_token
      params = { user: { email: user.email, password: user.password } }
      delete :destroy, params, format: :json
      assert_response :no_content
    end

    test '#DELETE #destroy does not remove if wrong credentials are submitted' do
      user = create(:user, email: 'email@example.com', password: '123456', auth_token: SecureRandom.base64(64))
      assert_not_nil user.auth_token
      params = { user: { email: user.email, password: '654321' } }
      delete :destroy, params, format: :json
      result = JSON.parse(response.body)
      assert_equal 'Nothing to do', result['error']
      assert_response :not_found
    end
  end
end
