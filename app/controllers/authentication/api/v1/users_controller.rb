class Authentication::Api::V1::UsersController < Authentication::Api::V1::BaseController
  before_action :find_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = Authentication::User(create_params)

    if @user.save
      @user.activate
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(update_params)
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

  def create_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :firstname, :lastname
    ).delete_if { |_k, v| v.nil? }
  end

  def update_params
    create_params
  end

  def find_user
    @user ||= Authentication::User.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User does not exist' }, status: :not_found
  end
end
