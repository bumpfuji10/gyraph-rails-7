class User < ApplicationRecord
  before_create :generate_confirmation_instructions

  has_many :practice_records
  has_one_attached :icon do |attachable|
    attachable.variant :large, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [50, 50]
    attachable.variant :small, resize_to_limit: [40, 40]
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
  has_secure_password

  generates_token_for :confirm_account, expires_in: 24.hours

  def generate_confirmation_instructions
    self.confirmation_token = generate_token_for(:confirm_account)
    self.confirmation_sent_at = Time.current
  end

  def confirm
    update(confirmed_at: Time.current, confirmation_token: nil)
  end

  def confirmed?
    confirmed_at.present?
  end
end
