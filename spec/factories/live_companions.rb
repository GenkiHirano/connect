FactoryBot.define do
  factory :live_companion do
    artist_name { "米津玄師" }
    live_name { "米津玄師 2020 TOUR / HYPE" }
    schedule { "2030-8-6" }
    live_memo { "誰か、米津玄師さんの一緒にライブ行きませんか...？" }
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

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_live_companion.jpg')) }
  end
end
