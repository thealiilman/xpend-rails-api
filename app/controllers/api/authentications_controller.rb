module Api
  class AuthenticationsController < ApiController
    skip_before_action :authenticate_request!
    before_action :set_user, only: :login

    def login
      create_session(@user.id)
      head :ok
    end

    private

    def set_user
      @user = User.find_by!(email: user_params[:email])

      render_error('User credentials are invalid', :bad_request) unless
        @user.authenticate(user_params[:password])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
