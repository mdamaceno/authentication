require 'test_helper'

module Authentication
  class Api::V1::SessionsController < ActionController::TestCase
    def setup
      @controller = Authentication::Api::V1::SessionsController.new
      @routes = Authentication::Engine.routes
    end

    
  end
end
