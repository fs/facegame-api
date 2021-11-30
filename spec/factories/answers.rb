FactoryBot.define do
  factory :answer do
    association :question
    association :result
    value { "value" }
    status { "incorrect" }
  end
end
