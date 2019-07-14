module AuthHelpers
  def authenticated_header(user)
    Knock::AuthToken.new(payload: { sub: user.id }).token
  end
end

RSpec.configure do |config|
  config.include AuthHelpers
end
