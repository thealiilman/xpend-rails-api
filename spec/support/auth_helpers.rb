# frozen_string_literal: true

module AuthHelpers
  def access_token(id)
    JsonWebToken.encode(
      user_id: id,
      exp: 30.minutes.from_now.to_i
    )
  end

  def refresh_token(user)
    JsonWebToken.encode(
      user_id: user.id,
      session_id: user.session_id,
      exp: 1.week.from_now.to_i
    )
  end

  def decode_access_token(token)
    JsonWebToken.decode(token)
  end

  # rubocop:disable Metrics/AbcSize
  def access_and_refresh_tokens_cookies(user)
    jar = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    jar.signed[:access_token] = cookie_body(access_token(user.id))
    jar.signed[:refresh_token] = cookie_body(refresh_token(user))
    cookies[:access_token] = jar[:access_token]
    cookies[:refresh_token] = jar[:refresh_token]
  end
  # rubocop:enable Metrics/AbcSize

  def cookie_body(token)
    {
      value: token,
      httponly: true,
      secure: false
    }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
end
