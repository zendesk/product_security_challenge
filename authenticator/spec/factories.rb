FactoryBot.define do
  factory :user do
    email
    password { "trustno1" }
  end

  sequence :email do |n|
    "user#{n}@example.com"
  end
end
