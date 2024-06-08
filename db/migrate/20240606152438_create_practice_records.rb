class CreatePracticeRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_records do |t|
      t.references :user, null: false, foreign_key: true

      t.string :title, null: false
      t.date :practiced_date, null: false
      t.timestamps
    end

    add_index :practice_records, :practiced_date
  end
end
