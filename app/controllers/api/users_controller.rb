module Api
  class UsersController < ApiController
    before_action :authenticate_user, only: %i[show update destroy]

    def create
      user = User.new(user_signup_params)
      return render_error(user.errors.messages, :unprocessable_entity) \
        unless user.save

      render json: UserSerializer.new(user), status: :created
    end

    def show
      render json: UserSerializer.new(current_user)
    end

    def update; end

    def destroy
      current_user.destroy
      head :ok
    end

    private

    def user_signup_params
      params.require(:user).permit(:username, :email, :password)
    end
  end
end
