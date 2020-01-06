User.create!(
    email: 'example@railstutorial.org',
    name: 'taro',
    account_name: 'taro',
    activated: true,
    password: 'aaaaaa',
    password_confirmation: 'aaaaaa',
    admin: true
 )

 User.create!(
    email: 'bbbbbb@gmail.com',
    name: 'ziro',
    account_name: 'ziro',
    activated: true,
    password: 'bbbbbb',
    password_confirmation: 'bbbbbb'
 )

    User.create!(
      email: 'guest@example.jp',
      name: 'Guest User',
      account_name: '@guest',
      activated: true,
      prof: "ゲストユーザー ",
      password: 'xxxxxx',
      password_confirmation: 'xxxxxx'
    
 )

 User.create!(
   email: 'dddddd@gmail.com',
   name: '魚魚魚魚魚魚魚魚魚魚',
   account_name: '魚魚魚魚魚魚魚魚魚魚',
   activated: true,
   password: 'dddddd',
   password_confirmation: 'dddddd'
   
)