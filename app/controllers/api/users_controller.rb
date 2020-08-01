module Api
  class UsersController < ApiController
    skip_before_action :authenticate_user, only: :create
    before_action :valid_password?, only: :update

    def create
      user = User.new(user_params)
      return render_error(user.errors.messages, :unprocessable_entity) \
        unless user.save

      render json: UserSerializer.new(user), status: :created
    end

    def show
      render json: UserSerializer.new(current_user)
    end

    def update
      return render_error(current_user.errors.messages, :unprocessable_entity) \
        unless current_user.update(user_params.except(:password))

      render json: UserSerializer.new(current_user)
    end

    def destroy
      current_user.destroy
      head :ok
    end

    private

    def user_params
      params.require(:user).permit(:given_name, :email, :password)
    end

    def valid_password?
      render_error('Invalid password', :bad_request) unless
        current_user.authenticate(user_params[:password])
    end
  end
end
