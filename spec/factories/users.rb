FactoryBot.define do
  factory :user do
    name { "test user" }
    email { "test@test.com" }
    password { "password" }
  end
end
