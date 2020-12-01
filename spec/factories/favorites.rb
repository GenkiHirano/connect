FactoryBot.define do
  factory :favorite do
    association :live_companion
    association :user
  end
end
