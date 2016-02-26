module Authentication
  class Api::V1::PasswordsController < Authentication::Api::V1::BaseController
    before_action :find_user, only: [:update]

    def update
      if @user.update(password_params)
        head :no_content
      else
        render @user.errors, status: :unprocessable_entity
      end
    end

    def forgot
      user = Authentication::User.find_by(email: email_params[:email])
      if user
        ResetPasswordMailer.confirmation(user).deliver_now
        head :no_content
      else
        render json: { error: 'not found' }, status: 404
      end
    end

    private

    def find_user
      @user ||= current_user
    end

    def password_params
      params.require(:user).permit(:password)
    end

    def email_params
      params.require(:user).permit(:email)
    end
  end
end
