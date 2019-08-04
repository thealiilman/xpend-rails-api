class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :title, null: false
      t.string :description
      t.monetize :amount
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
