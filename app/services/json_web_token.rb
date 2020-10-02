class JsonWebToken
  SECRET_KEY_BASE = Rails.application.credentials.secret_key_base

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY_BASE, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY_BASE, true, algorithm: 'HS256')
  end
end
