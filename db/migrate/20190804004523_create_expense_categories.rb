class CreateExpenseCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_categories do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
