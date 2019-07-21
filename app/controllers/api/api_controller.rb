module Api
  class ApiController < ApplicationController
    include Knock::Authenticable
    include Concerns::ErrorHandler
  end
end
