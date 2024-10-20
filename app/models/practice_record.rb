class PracticeRecord < ApplicationRecord
  belongs_to :user
  has_many :practice_record_details, dependent: :destroy
  has_many :likes, dependent: :destroy

  accepts_nested_attributes_for :practice_record_details, allow_destroy: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :practiced_date, presence: true

  alias_attribute :details, :practice_record_details

  def is_mine?(user:)
    self.user_id == user.id
  end
end
