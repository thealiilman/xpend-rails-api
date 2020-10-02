module Api
  class ApiController < ApplicationController
    include ActionController::Cookies
    include Concerns::Authenticator
    include Concerns::ErrorHandler
  end
end
