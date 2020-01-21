User.create!(
    email: 'sample@gmail.com',
    name: 'sample',
    account_name: '@sample',
    picture: '/prof_1.JPG',
    activated: true,
    prof: "ブリよりカンパチ派",
    password: 'sample',
    password_confirmation: 'sample',
    admin: true
 )

 User.create!(
    email: 'sampleb@gmail.com',
    name: 'sampleb',
    account_name: '@sampleb',
    picture: '/prof_2.JPG',
    activated: true,
    prof: "魚大好き",
    password: 'sampleb',
    password_confirmation: 'sampleb'
 )

    User.create!(
      email: 'guest@example.jp',
      name: 'Guest User',
      account_name: '@guest',
      picture: '/geust_user.JPG',
      activated: true,
      prof: "ゲストユーザー ",
      password: 'xxxxxx',
      password_confirmation: 'xxxxxx'
    
 )

Review.create!(
   user_id: 1,
   #石鯛
   fish_id: 134,
   taste_level: 3,
   season: 5,
   place: "千葉県",
   place_detail: "館山",
   recipe: "刺身",
   preservation_period: 0,
   fish_size: 40,
   blood: true,
   taste_imp: "若干臭みがあったが美味しかった。",
   picture: "/review_1.JPG"
)

Review.create!(
   user_id: 2,
   #アカハタ
   fish_id: 49,
   taste_level: 4,
   season: 1,
   place: "神奈川県",
   place_detail: "江ノ島",
   recipe: "煮付け",
   preservation_period: 3,
   fish_size: 42,
   blood: true,
   taste_imp: "熟成したことによって身の旨味が強くなっていて美味しかった。",
   picture: "/akahata.JPG"
)

Review.create!(
   user_id: 3,
   #メバル
   fish_id: 62,
   taste_level: 5,
   season: 3,
   place: "鹿児島県",
   place_detail:"枕崎",
   recipe: "焼き(干物)",
   preservation_period: 2,
   fish_size: 30,
   blood: true,
   taste_imp: "旨味がすごい！　I LOVE HIMONO!",
   picture: "/mebaru.JPG"
)