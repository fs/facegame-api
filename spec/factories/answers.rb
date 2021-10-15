FactoryBot.define do
  factory :answer do
    association :question
    value { "value" }
  end
end
