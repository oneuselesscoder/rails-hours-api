FactoryBot.define do
  factory :hour do
    starts { Faker::Date.between(2.days.ago, Date.today) }
    ends { Faker::Date.between(2.days.ago, Date.today) }
    user_id nil
  end
end