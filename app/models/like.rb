class Like < ApplicationRecord
  belongs_to :user
  belongs_to :practice_record
end
