FactoryBot.define do
  sequence :user_email do |n|
    "user_#{n}@flatstack.com"
  end
  sequence :activity_title do |n|
    "User ##{n} registered!"
  end
end
