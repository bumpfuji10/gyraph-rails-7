class PracticeRecordDetail < ApplicationRecord
  belongs_to :practice_record

  validates :activity_title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 10000 }

end
