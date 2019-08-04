class ExpenseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title,
             :description,
             :amount_cents,
             :amount_currency,
             :user_id

  belongs_to :expense_category
end
