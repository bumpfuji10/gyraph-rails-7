class CreateUserPasswordResets < ActiveRecord::Migration[7.1]
  def change
    create_table :user_password_resets do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :reset_password_token, null: false, index: { unique: true , name: "unique_reset_password_token" }
      t.datetime :reset_password_sent_at, null: false

      t.timestamps
    end
  end
end
