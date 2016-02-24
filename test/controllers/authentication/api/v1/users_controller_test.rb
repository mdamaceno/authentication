require 'test_helper'

module Authentication
  class Api::V1::UsersControllerTest < ActionController::TestCase
    def setup
      @controller = Authentication::Api::V1::UsersController.new
      @routes = Authentication::Engine.routes
    end

    # GET #index

    test 'GET #index returns all the users' do
      result = json_parsed('index', 10, 'user')
      assert_equal 10, result.length
    end
  end
end
