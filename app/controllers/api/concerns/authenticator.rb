# frozen_string_literal: true

module Api
  module Concerns
    module Authenticator
      extend ActiveSupport::Concern

      included do
        before_action :authenticate_request!
      end

      private

      def current_user
        @current_user ||= User.find(access_token_payload['user_id'])
      end

      def authenticate_request!
        verify_or_refresh_access_token
      rescue JWT::DecodeError, JWT::ExpiredSignature => e
        render_error(e.message, :unauthorized)
      end

      def verify_or_refresh_access_token
        access_token_payload
      rescue JWT::ExpiredSignature
        validate_session
        create_session(refresh_token_payload['user_id'])
      end

      def validate_session
        user = User.find(refresh_token_payload['user_id'])
        return head(:unauthorized) unless
          refresh_token_payload['session_id'] == user.session_id
      end

      def create_session(user_id)
        session_id = SecureRandom.hex
        return head(:unauthorized) unless
          User.find(user_id).update(session_id: session_id)

        store_access_token_in_cookies(user_id)
        store_refresh_token_in_cookies(user_id, session_id)
      end

      def store_access_token_in_cookies(user_id)
        access_token = JsonWebToken.encode(
          user_id: user_id,
          exp: 30.minutes.from_now.to_i
        )

        cookies.signed[:access_token] = cookie_body(access_token)
      end

      def store_refresh_token_in_cookies(user_id, session_id)
        refresh_token = JsonWebToken.encode(
          user_id: user_id,
          session_id: session_id,
          exp: 1.week.from_now.to_i
        )

        cookies.signed[:refresh_token] = cookie_body(refresh_token)
      end

      def cookie_body(token)
        body = {
          value: token,
          httponly: true,
          secure: Rails.env.production?
        }

        body.merge!(same_site: :none) if Rails.env.production?

        body
      end

      def access_token_payload
        @access_token_payload = JsonWebToken.decode(cookies.signed[:access_token]).first
      end

      def refresh_token_payload
        @refresh_token_payload = JsonWebToken.decode(cookies.signed[:refresh_token]).first
      end
    end
  end
end
