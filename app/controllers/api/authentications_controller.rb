module Api
  class AuthenticationsController < ApiController
    before_action :set_user, only: :login

    def login
      render json: KnockToken.generate(@user.id), status: :created
    end

    private

    def set_user
      @user = User.find_by!(username: user_params[:username])
      return render_error unless @user.authenticate(user_params[:password])

      @user
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end

    def render_error
      render json: { message: 'User credentials are invalid' },
             status: :bad_request
    end
  end
end
