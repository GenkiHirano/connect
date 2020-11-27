FactoryBot.define do
  factory :live_companion do
    artist_name { "米津玄師" }
    live_name { "米津玄師 2020 TOUR / HYPE" }
    schedule { "2021-8-6" }
    live_memo { "米民さん、誰か一緒にライブ行きませんか...？" }
    association :user
    created_at { Time.current } 
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end
end
