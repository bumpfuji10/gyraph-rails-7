FactoryBot.define do
  factory :practice_record do
    user
    title { "今日の練習" }
    practiced_date { "2024-04-04" }
  end
end
