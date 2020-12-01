FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    introduction { "はじめまして。米津玄師が好きです！" }
    sex { "男性" }

    trait :admin do
      admin { true }
    end
  end
end
