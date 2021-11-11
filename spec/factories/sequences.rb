FactoryBot.define do
  sequence :user_email do |n|
    "user_#{n}@flatstack.com"
  end
end
