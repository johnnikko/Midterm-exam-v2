FactoryBot.define do
  factory :article do
    title {Faker::DcComics.hero}
    content {Faker::String.random}
    category{}
    user{}
  end
end
