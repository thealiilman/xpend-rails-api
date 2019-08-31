class ExpenseSerializer < ApplicationSerializer
  attributes :title,
             :description,
             :user_id

  attribute :amount do |object, params|
    if params[:currency]
      object.amount.exchange_to(params[:currency]).to_f
    else
      object.amount.to_f
    end
  end

  attribute :amount_currency do |object, params|
    params[:currency] || object.amount_currency
  end

  attribute :expense_category do |object|
    ExpenseCategorySerializer.new(object.expense_category)
  end
end
