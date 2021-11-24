FactoryBot.define do
  factory :answer do
    association :question
    association :result
    value { "value" }
    correct { false }
  end
end
