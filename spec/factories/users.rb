FactoryBot.define do
  factory :user do
    email{Faker::Internet.email}
    password{'qwer4321'}
  end
end
