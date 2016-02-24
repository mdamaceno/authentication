module Authentication
  class Api::V1::UsersController < Authentication::Api::V1::BaseController
    def index
      @users = Authentication::User.all
      render json: @users
    end
  end
end
