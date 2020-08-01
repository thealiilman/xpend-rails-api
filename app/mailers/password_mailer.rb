class PasswordMailer < ApplicationMailer
  def request_for_a_reset(user)
    @given_name = user.given_name
    @reset_password_digest = user.reset_password_digest
    mail(to: user.email,
         subject: 'Instructions to reset your password')
  end
end
