FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "よかったら一緒に行きませんか...？" }
    association :live_companion
  end
end
