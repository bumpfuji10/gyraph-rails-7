class ChangeContentColumnTypeInPracticeRecordDetails < ActiveRecord::Migration[7.1]
  def change
    change_column :practice_record_details, :content, :text
  end
end
