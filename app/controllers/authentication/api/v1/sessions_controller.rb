module Authentication
  class Api::V1::SessionsController < Authentication::Api::V1::BaseController
    skip_before_action :verify_authentication, only: [:create]

    def create
      user = Authentication::User.find_by(email: session_params[:email])
      if user && user.authenticate(session_params[:password])
        user.update_attribute(:auth_token, SecureRandom.base64(64))
        response.headers['api-token'] = user.auth_token
        render json: user
      else
        render json: { error: 'not authorized' }, status: 403
      end
    end

    def destroy
      token = request.headers['api-token']
      return render json: { error: 'not authorized' }, status: 403 if token.nil?

      if current_user
        current_user.update_attribute(:auth_token, nil)
        head :no_content
      else
        render json: { error: 'not authorized' }, status: 403
      end
    end

    private

    def session_params
      params.require(:user).permit(:email, :password)
    end
  end
end
