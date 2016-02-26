module Authentication
  class Api::V1::BaseController < ApplicationController
    before_action :verify_authentication

    def unauthorized!
      render json: { error: 'not authorized' }, status: 403
    end

    def current_user
      token = request.headers['api-token']
      @user ||= Authentication::User.find_by(auth_token: token) unless token.nil?
    end

    protected

    def verify_authentication
      token = request.headers['api-token']

      return unauthorized! if token.nil?

      user = Authentication::User.find_by(auth_token: token)

      return unauthorized! if user.nil?
    end
  end
end
