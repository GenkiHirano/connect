FactoryBot.define do
  factory :live_list do
    association :user
    association :live_companion
  end
end
