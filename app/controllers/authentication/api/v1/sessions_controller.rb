module Authentication
  class Api::V1::SessionsController < Authentication::Api::V1::BaseController
    skip_before_action :verify_authentication, only: [:create]

    def create
      user = Authentication::User.find_by_email_and_password(session_params[:email], session_params[:password])
      unless user.nil?
        user.update_attribute(:auth_token, SecureRandom.base64(64))
        response.headers['api-key'] = user.auth_token
        render json: user
      else
        render json: { error: 'Something is wrong' }, status: :not_found
      end
    end

    def destroy
      user = Authentication::User.find_by_email_and_password(session_params[:email], session_params[:password])
      unless user.nil?
        user.update_attribute(:auth_token, nil)
        head :no_content
      else
        render json: { error: 'Something is wrong' }, status: :not_found
      end
    end

    private

    def session_params
      params.require(:user).permit(:email, :password)
    end
  end
end
