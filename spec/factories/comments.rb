FactoryBot.define do
  factory :comment do
    live_companion_id { 1 }
    user_id { 1 }
    content { "MyText" }
  end
end
