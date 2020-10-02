module Api
  class PasswordsController < ApiController
    skip_before_action :authenticate_request!

    def forgot
      return render_error('User does not exist!', :not_found) unless
        (user = User.find_by(email: forgot_password_params[:email]))

      Password::RequestReset.run(user)
      head :ok
    end

    def reset
      user = User.find_by(
        reset_password_digest: reset_password_params[:reset_password_digest]
      )

      return render_error('User did not request for a reset!', :bad_request) \
        unless user

      reset = Password::Reset.run(user, reset_password_params[:new_password])
      return render_error(reset.error, :bad_request) unless reset.success?

      head :ok
    end

    private

    def forgot_password_params
      params.permit(:email)
    end

    def reset_password_params
      params.permit(:new_password, :reset_password_digest)
    end
  end
end
