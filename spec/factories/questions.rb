FactoryBot.define do
  factory :question do
    email { generate(:user_email) }
    full_name { FFaker::Name.name }
    department { "ios" }
  end
end
