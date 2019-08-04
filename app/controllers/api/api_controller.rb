module Api
  class ApiController < ApplicationController
    include Knock::Authenticable
    include Concerns::ErrorHandler

    before_action :authenticate_user
  end
end
