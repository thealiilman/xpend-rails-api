class AddResetPasswordAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :reset_password_digest
      t.datetime :reset_password_email_sent_at
    end
  end
end
