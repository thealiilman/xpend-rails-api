module Password
  class Reset
    attr_reader :user, :new_password

    class << self
      def run(user, new_password)
        new(user, new_password).run
      end
    end

    def initialize(user, new_password)
      @user = user
      @new_password = new_password
    end

    def run
      return non_unique_password_error if same_password?

      user.update(
        reset_password_digest: nil,
        reset_password_email_sent_at: nil,
        password: new_password
      )
      OpenStruct.new(success?: true)
    end

    private

    def non_unique_password_error
      OpenStruct.new(success?: false, error: 'Please use a unique password')
    end

    def same_password?
      user.authenticate(new_password)
    end
  end
end
