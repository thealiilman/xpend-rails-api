module Api
  class ApiController < ApplicationController
    include Knock::Authenticable
  end
end
