module Api
  class AuthenticationsController < ApiController
    skip_before_action :authenticate_user
    before_action :set_user, only: :login

    def login
      render json: KnockToken.generate(@user.id), status: :created
    end

    private

    def set_user
      @user = User.find_by!(username: user_params[:username])

      render_error('User credentials are invalid', :bad_request) unless
        @user.authenticate(user_params[:password])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
end
