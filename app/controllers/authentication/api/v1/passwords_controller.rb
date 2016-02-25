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

    private

    def find_user
      @user ||= current_user
    end

    def password_params
      params.require(:user).permit(:password)
    end
  end
end
