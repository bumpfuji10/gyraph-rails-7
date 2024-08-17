FactoryBot.define do
  factory :user_password_reset do
    user { nil }
    reset_password_token { "MyString" }
    reset_password_sent_at { "2024-08-17 18:24:37" }
  end
end
