User.create!(
  [
    {
      name: "米津玄師ファン",
      email: "yonezu@example.com",
      password: "yonezu",
      password_confirmation: "yonezu",
      introduction: "米津玄師が好きです！"
    },
    {
      name: "サザンオールスターズファン",
      email: "southern@example.com",
      password: "southern",
      password_confirmation: "southern",
      introduction: "サザンオールスターズファン歴10年です。"
    },
    {
      name: "J-pop大好きさん",
      email: "j-poppop@example.com",
      password: "j-poppop",
      password_confirmation: "j-poppop",
      introduction: "流行りのJ-popはなんでも聴きます！"
    },
    {
      name: "ロック大好きさん",
      email: "rockrock@example.com",
      password: "rockrock",
      password_confirmation: "rockrock",
      introduction: "ロック最高！！！"
    },
    {
      name: "ゲストユーザー様",
      email: "guest@example.com",
      password: "password",
      password_confirmation: "password",
      introduction: "誰か一緒にライブ行きましょう！",
      admin: true
    },
  ]
)

user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user4 = User.find(4)
user5 = User.find(5)
user5.follow(user1)
user5.follow(user2)
user5.follow(user3)
user5.follow(user4)

LiveCompanion.create!(
  [
    {
      artist_name: "米津玄師",
      live_name: "米津玄師 2020 TOUR / HYPE",
      schedule: "2021-2-27",
      live_venue: "宮城セキスイハイムスーパーアリーナ",
      live_memo: "誰か、米津玄師さんのライブに一緒に行きませんか...？",
      picture: open("#{Rails.root}/public/images/artist-picture/Kenshi Yonezu.jpg"),
      user_id: 1
    },
    {
      artist_name: "米津玄師",
      live_name: "米津玄師 2020 TOUR / HYPE",
      schedule: "2021-3-7",
      live_venue: "三重県営サンアリーナ",
      live_memo: "誰か、米津玄師さんのライブに一緒に行きませんか...？",
      picture: open("#{Rails.root}/public/images/artist-picture/Kenshi Yonezu.jpg"),
      user_id: 1
    },
    {
      artist_name: "米津玄師",
      live_name: "米津玄師 2020 TOUR / HYPE",
      schedule: "2021-3-26",
      live_venue: "マリンメッセ福岡",
      live_memo: "誰か、米津玄師さんのライブに一緒に行きませんか...？",
      picture: open("#{Rails.root}/public/images/artist-picture/Kenshi Yonezu.jpg"),
      user_id: 1
    },
    {
      artist_name: "サザンオールスターズ",
      live_name: "ALL THAT サザンオールスターズ",
      schedule: "2021-5-23",
      live_venue: "横浜アリーナ",
      live_memo: "サザンのライブに一緒に行きましょう！",
      picture: open("#{Rails.root}/public/images/artist-picture/Southern All Stars.jpg"),
      user_id: 2
    },
    {
      artist_name: "サザンオールスターズ",
      live_name: "ALL THAT サザンオールスターズ",
      schedule: "2021-11-7",
      live_venue: "大阪厚生年金会館",
      live_memo: "サザンのライブに一緒に行きましょう！",
      picture: open("#{Rails.root}/public/images/artist-picture/Southern All Stars.jpg"),
      user_id: 2
    },
    {
      artist_name: "RADWIMPS",
      live_name: "胎盤ツアー",
      schedule: "2021-10-27",
      live_venue: "東京ドーム",
      live_memo: "胎盤ツアー行きましょう！",
      picture: open("#{Rails.root}/public/images/artist-picture/RADWIMPS.jpg"),
      user_id: 3
    },
    {
      artist_name: "きゃりーぱみゅぱみゅ",
      live_name: "ファッションモンスターツアー",
      schedule: "2021-9-14",
      live_venue: "東京ドーム",
      live_memo: "誰か、一緒に踊りましょう...！！",
      picture: open("#{Rails.root}/public/images/artist-picture/Kyary Pamyu Pamyu.jpg"),
      user_id: 3
    },
    {
      artist_name: "あいみょん",
      live_name: "AIMYON TOUR 2021 'ミート・ミート'",
      schedule: "2021-12-7",
      live_venue: "大阪城ホール",
      live_memo: "大阪初めてです！誰か一緒に参加してくださいませんか...？",
      picture: open("#{Rails.root}/public/images/artist-picture/Aimyon.jpg"),
      user_id: 3
    },
    {
      artist_name: "BISH",
      live_name: "BiSH 'TO THE END,THE END'",
      schedule: "2021-5-22",
      live_venue: "神奈川・横浜アリーナ",
      live_memo: "清掃員の方、一緒に行きましょう！",
      picture: open("#{Rails.root}/public/images/artist-picture/BiSH.jpg"),
      user_id: 3
    },
    {
      artist_name: "Official髭男dism",
      live_name: "Official髭男dism Tour 2021",
      schedule: "2021-4-4",
      live_venue: "タワーレコード新宿店",
      live_memo: "Pretender聴きたい！！！",
      picture: open("#{Rails.root}/public/images/artist-picture/Official Hige Dandism.jpg"),
      user_id: 3
    },
    {
      artist_name: "嵐",
      live_name: "ARASHI Anniversary Tour",
      schedule: "2021-9-30",
      live_venue: "東京ドーム",
      live_memo: "実は嵐も好きです！誰か一緒に行こう！！",
      picture: open("#{Rails.root}/public/images/artist-picture/ARASHI.jpg"),
      user_id: 3
    },
    {
      artist_name: "King Gnu",
      live_name: "King Gnu Live Tour 2021 AW “CEREMONY”",
      schedule: "2021-12-1",
      live_venue: "日本ガイシホール",
      live_memo: "初めまして！よかったら一緒に行きませんか...？ 白日聴きたい！",
      picture: open("#{Rails.root}/public/images/artist-picture/King Gnu.jpg"),
      user_id: 4
    },
    {
      artist_name: "Vaundy",
      live_name: "2nd one man live “strobo”",
      schedule: "2021-10-10",
      live_venue: "Zepp Haneda",
      live_memo: "ゆったり観ましょう。",
      picture: open("#{Rails.root}/public/images/artist-picture/Vaundy.jpg"),
      user_id: 4
    },
    {
      artist_name: "Mr.Children",
      live_name: "Mr.Children Tour 2021 重力と呼吸",
      schedule: "2021-10-6",
      live_venue: "広島グリーンアリーナ",
      live_memo: "ミスチル一緒に行きましょう！！",
      picture: open("#{Rails.root}/public/images/artist-picture/Mr.Children.jpg"),
      user_id: 5
    },
    {
      artist_name: "スピッツ",
      live_name: "CONCERT TOUR 2021 名前のないツアー",
      schedule: "2021-12-17",
      live_venue: "日本青年館",
      live_memo: "スピッツ、人生で一度だけでいいから観たいです。一緒に行ってくださいませんか？",
      picture: open("#{Rails.root}/public/images/artist-picture/Spitz.jpg"),
      user_id: 5
    },
    {
      artist_name: "米津玄師",
      live_name: "米津玄師 2017 LIVE / RESCUE",
      schedule: "2021-7-14",
      live_venue: "東京国際フォーラム",
      live_memo: "初めての米津さんのライブです。一緒に行きましょう！",
      picture: open("#{Rails.root}/public/images/artist-picture/Kenshi Yonezu.jpg"),
      user_id: 5
    }
  ]
)

live_companion1 = LiveCompanion.find(1)
live_companion8 = LiveCompanion.find(8)
live_companion14 = LiveCompanion.find(14)
live_companion15 = LiveCompanion.find(15)

user3.favorite(live_companion14)
user4.favorite(live_companion15)
user5.favorite(live_companion1)
user5.favorite(live_companion8)

live_companion14.comments.create(user_id: user3.id, content: "よかったら一緒に行きませんか...？")
live_companion15.comments.create(user_id: user4.id, content: "はじめまして！一緒に行きましょう！")

user5.notifications.create(user_id: user5.id, live_companion_id: live_companion14.id,
                           from_user_id: user3.id, variety: 1)
user5.notifications.create(user_id: user5.id, live_companion_id: live_companion14.id,
                           from_user_id: user3.id, variety: 2, content: "よかったら一緒に行きませんか...？")
user5.notifications.create(user_id: user5.id, live_companion_id: live_companion15.id,
                           from_user_id: user4.id, variety: 1)
user5.notifications.create(user_id: user5.id, live_companion_id: live_companion15.id,
                           from_user_id: user4.id, variety: 2, content: "はじめまして！一緒に行きましょう！")

user3.live_list(live_companion14)
user4.live_list(live_companion15)
