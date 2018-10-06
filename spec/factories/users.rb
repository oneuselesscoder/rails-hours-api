FactoryBot.define do
  factory :user do
    user_name { Faker::Lorem.word }
  end
end