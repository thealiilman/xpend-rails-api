class ExpenseSerializer < ApplicationSerializer
  attributes :title,
             :description,
             :user_id,
             :amount_currency

  attribute :amount do |object|
    object.amount.to_f
  end

  attribute :expense_category do |object|
    ExpenseCategorySerializer.new(object.expense_category)
  end
end
