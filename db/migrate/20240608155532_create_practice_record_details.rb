class CreatePracticeRecordDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_record_details do |t|
      t.references :practice_record, null: false, foreign_key: true

      t.string :activity_title, null: false
      t.string :content, null: false
      t.timestamps
    end
  end
end
