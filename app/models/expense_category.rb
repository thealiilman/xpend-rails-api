class ExpenseCategory < ApplicationRecord
  has_many :expenses, dependent: :nullify

  validates :title, presence: true
end
