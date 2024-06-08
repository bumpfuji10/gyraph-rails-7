class PracticeRecord < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :practiced_date, presence: true
end
