class KnockToken
  def self.generate(user_id)
    Knock::AuthToken.new(payload: { sub: user_id })
  end
end
