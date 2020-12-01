User.create!(name: "山田 太郎",
             email: "sample@example.com",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
name  = Faker::Name.name
email = "sample-#{n + 1}@example.com"
password = "password"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password)
end

10.times do |n|
  LiveCompanion.create!(
    artist_name: "米津玄師",
    live_name: "米津玄師 2020 TOUR / HYPE",
    live_memo: "誰か、米津玄師さんのライブに一緒に行きませんか...？",
    user_id: 1
  )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }