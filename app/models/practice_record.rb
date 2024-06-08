class PracticeRecord < ApplicationRecord
  belongs_to :user
  has_many :practice_record_details

  validates :title, presence: true, length: { maximum: 100 }
  validates :practiced_date, presence: true
end
