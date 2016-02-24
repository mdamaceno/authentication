require 'test_helper'

module Authentication
  class Api::V1::UsersControllerTest < ActionController::TestCase
    def setup
      @controller = Authentication::Api::V1::UsersController.new
      @routes = Authentication::Engine.routes
      u = create(:user, auth_token: SecureRandom.base64(64))
      request.headers['api-token'] = u.auth_token
    end

    # GET #index

    test 'GET #index returns all the users' do
      result = json_parsed('index', 10, 'user')
      assert_equal 11, result.length
    end

    # GET #show

    test 'GET #show returns data of an single user' do
      user = create(:user)
      result = json_parsed('show', nil, nil, user)
      assert_not_nil result
    end

    test 'GET #show does not returns a user if api-token does not exist' do
      user = create(:user)
      request.headers['api-token'] = SecureRandom.base64(64)
      result = json_parsed('show', nil, nil, user)
      assert_equal 'not authorized', result['error']
      assert_response 403
    end

    test 'GET #show returns 404 if user is not found' do
      result = get :show, id: 999, format: :json
      assert_response :not_found
    end

    # POST #create

    test 'POST #create returns a successful json string with the new user' do
      attributes = attributes_for(:user, name: 'Marco')
      result = json_parsed('create', nil, 'user', attributes)
      assert_equal 'Marco', result['name']
      assert_equal 'marco', result['slug']
    end

    test 'POST #create returns an error if name is not submitted' do
      attributes = attributes_for(:user, name: nil)
      result = json_parsed('create', nil, 'user', attributes)
      assert_response :unprocessable_entity
      assert_includes result['name'], "can't be blank"
    end

    # PUT #update

    test 'PUT #update returns a successful json string with the updated user' do
      user = create(:user, name: 'Marco')
      attributes = attributes_for(:user, name: 'Antonio')
      result = json_parsed('update', nil, 'user', user, attributes)
      assert_equal 'Antonio', result['name']
    end

    test 'PUT #update returns an error if name is null' do
      user = create(:user, name: 'Marco')
      attributes = attributes_for(:user, name: nil)
      result = json_parsed('update', nil, 'user', user, attributes)
      assert_includes result['name'], "can't be blank"
    end

    # DELETE #destroy

    test 'DELETE #destroy removes a user and returns nothing' do
      user = create(:user)
      delete :destroy, id: user, format: :json
      assert_response :no_content
    end
  end
end
