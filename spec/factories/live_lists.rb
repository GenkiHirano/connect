FactoryBot.define do
  factory :live_list do
    from_user_id { 1 }
    association :user
    association :live_companion
  end
end
