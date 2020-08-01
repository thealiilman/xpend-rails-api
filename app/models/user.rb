class User < ApplicationRecord
  has_secure_password

  has_many :expenses, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :given_name, presence: true
end
