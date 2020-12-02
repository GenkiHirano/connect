FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "よかったら一緒に行きませんか...？ 私もちょうど行きたかったんです！" }
    association :live_companion
  end
end
