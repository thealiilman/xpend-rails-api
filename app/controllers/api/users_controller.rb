module Api
  class UsersController < ApiController
    before_action :authenticate_user, only: %i[show update destroy]

    def create; end

    def show
      render json: UserSerializer.new(current_user)
    end

    def update; end

    def destroy; end
  end
end
