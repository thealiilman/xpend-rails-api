class AddGivenNameToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      # There is a user on production, which is why the
      # default is required.
      t.string :given_name, null: false, default: ''
    end
  end
end
