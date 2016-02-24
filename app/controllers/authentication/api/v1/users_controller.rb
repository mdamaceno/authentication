module Authentication
  class Api::V1::UsersController < Authentication::Api::V1::BaseController
    before_action :find_user, only: [:show, :update, :destroy]

    def index
      @users = Authentication::User.all
      render json: @users
    end

    def show
      render json: @user
    end

    def create
      @user = Authentication::User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      head :no_content
    end

    private

    def find_user
      @user ||= Authentication::User.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User does not exist' }, status: :not_found
    end

    def user_params
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :status
      )
    end
  end
end
