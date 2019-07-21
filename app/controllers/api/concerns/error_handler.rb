module Api
  module Concerns
    module ErrorHandler
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound,
                    with: :render_not_found_error
        rescue_from ActiveRecord::RecordInvalid,
                    with: :render_invalid_record_error
      end

      def render_error(message, status)
        status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
        render json: { error: { status: status_code, message: message } },
               status: status
      end

      def render_not_found_error
        render_error('Not Found!', :not_found)
      end

      def render_invalid_record_error(error)
        render_error(error.message, :unprocessable_entity)
      end
    end
  end
end
