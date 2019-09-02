module Api
  class ExpenseCategoriesController < ApiController
    def index
      expense_categories = ExpenseCategory.order(title: :asc)
      render json: ExpenseCategorySerializer.new(expense_categories)
    end
  end
end
