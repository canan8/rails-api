FactoryBot.define do
  factory :article do
    title { "Sample article" }
    content { "Some content" }
    sequence(:slug) { |n| "sample-article#{n}" }
  end
end
