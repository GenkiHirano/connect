FactoryBot.define do
  factory :live_companion do
    user_id { 1 }
    artist_name { "MyString" }
    live_name { "MyString" }
    schedule { "2020-11-28" }
    live_memo { "MyText" }
    user { nil }
  end
end
