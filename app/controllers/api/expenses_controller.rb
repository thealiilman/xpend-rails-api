module Api
  class ExpensesController < ApiController
    before_action :set_expense, only: %i[update destroy]

    def index
      expenses = current_user.expenses
      render json: ExpenseSerializer.new(
        expenses,
        params: { currency: filter_params[:currency] }
      )
    end

    def create
      expense = current_user.expenses.new(expense_params)
      return render_error(expense.errors.messages, :unprocessable_entity) \
        unless expense.save

      render json: ExpenseSerializer.new(expense), status: :created
    end

    def update
      expense = Expense.find(params[:id])
      return render_error(expense.errors.messages, :unprocessable_entity) \
        unless expense.update(expense_params)

      render json: ExpenseSerializer.new(expense)
    end

    def destroy
      @expense.destroy
      head :ok
    end

    private

    def filter_params
      params.permit(:currency)
    end

    def expense_params
      params
        .require(:expense)
        .permit(:title, :description, :amount_cents, :amount_currency,
                :expense_category_id)
    end

    def set_expense
      @expense = Expense.find(params[:id])
    end
  end
end
