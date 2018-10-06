FactoryBot.define do
  factory :hour do
    starts { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    ends { Faker::Time.between(DateTime.now - 3, DateTime.now - 2) }
    valid_date  { Faker::Date.between(2.days.ago, Date.today) }
    user_id nil
  end
end