class AddIndexOnEmailInUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.remove_index :email
      t.index :email, unique: true
    end
  end
end
