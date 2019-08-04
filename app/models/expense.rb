class Expense < ApplicationRecord
  belongs_to :expense_category
  belongs_to :user

  validates :title, presence: true
  validates :description, length: { maximum: 200 }, allow_blank: true

  monetize :amount_cents
end
