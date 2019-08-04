class ExpenseSerializer < ApplicationSerializer
  attributes :title,
             :description,
             :amount_cents,
             :amount_currency,
             :user_id

  attribute :expense_category do |object|
    ExpenseCategorySerializer.new(object.expense_category)
  end
end
