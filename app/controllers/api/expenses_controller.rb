module Api
  class ExpensesController < ApiController
    def index
      expenses = current_user.expenses
      render json: ExpenseSerializer.new(expenses)
    end

    def create
      expense = Expense.new(expense_params)
      return render_error(expense.errors.messages, :unprocessable_entity) \
        unless expense.save

      render json: ExpenseSerializer.new(expense), status: :created
    end

    private

    def expense_params
      params
        .require(:expense)
        .permit(:title, :description, :amount_cents, :amount_currency,
                :user_id, :expense_category_id)
    end
  end
end
