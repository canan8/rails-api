FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "ricksanchec#{n}" }
    name { "Rick Sanchez" }
    url { "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "github" }
  end
end
