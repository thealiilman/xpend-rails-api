class AddExpenseCategoryToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :expense_category, foreign_key: true
  end
end
