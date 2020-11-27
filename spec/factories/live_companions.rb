FactoryBot.define do
  factory :live_companion do
    artist_name { "米津玄師" }
    live_name { "米津玄師 2020 TOUR / HYPE" }
    schedule { "2021-8-6" }
    live_memo { "米民さん、誰か一緒にライブ行きませんか...？" }
    association :user
  end
end
