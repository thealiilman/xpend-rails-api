class User < ApplicationRecord
  has_secure_password

  has_many :expenses, dependent: :destroy

  validates :username, :email,
            presence: true, uniqueness: { case_sensitive: false }
  validates :username,
            length: { in: 2..16 },
            format: {
              with: /\A[a-zA-Z_]+\z/,
              message: 'has non-alphanumeric & non-underscore characters'
            }
end
