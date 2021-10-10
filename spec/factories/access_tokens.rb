FactoryBot.define do
  factory :access_token do
    sequence(:token) { |n| "token#{n}" }
    user { nil }
  end
end
