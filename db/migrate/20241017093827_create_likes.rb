class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :practice_record, null: false, foreign_key: true

      t.timestamps
    end

    add_index :likes, [:user_id, :practice_record_id], unique: true, name: "index_likes_on_user_id_and_practice_record_id"
  end
end
