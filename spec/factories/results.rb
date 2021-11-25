FactoryBot.define do
  factory :result do
    association :user

    finish_at { Time.current }
  end
end
