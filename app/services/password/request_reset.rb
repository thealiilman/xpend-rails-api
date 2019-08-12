module Password
  class RequestReset
    attr_reader :user

    class << self
      def run(user)
        new(user).run
      end
    end

    def initialize(user)
      @user = user
    end

    def run
      user.reset_password_digest = SecureRandom.urlsafe_base64
      user.reset_password_email_sent_at = Time.current
      user.save!
      PasswordMailer.request_for_a_reset(user).deliver_later
    end
  end
end
