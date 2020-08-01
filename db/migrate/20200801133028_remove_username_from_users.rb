class RemoveUsernameFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      # rubocop:disable Rails/ReversibleMigration
      t.remove :username
      # rubocop:enable Rails/ReversibleMigration
    end
  end
end
