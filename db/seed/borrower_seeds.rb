@lenders = [
  [id: 0,
  first_name: "Jon",
  last_name: "Snow",
  email: "jsnow@whitewall.gov",
  password: "password",
  password_confirmation: "password",
  role: "lender"],

  [id: 27,
  first_name: "Lender",
  last_name: "McLender",
  email: "lender@keevaah.com",
  password: "password",
  password_confirmation: "password",
  role: "lender",
  nickname: 'hildawg']
]

@borrowers = []
200.times do |i|
  @borrowers << [
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    role: 'borrower'
  ]
end

@admins = [
  [id: 22,
  first_name: "Jeff",
  last_name: "Casimir",
  email: "demo+jeff@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'j3'],

  [id: 23,
  first_name: "Jorge",
  last_name: "Tellez",
  email: "demo+jorge@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'novohispano'],

  [id: 24,
  first_name: "Josh",
  last_name: "Cheek",
  email: "demo+josh@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'josh'],

  [id: 25,
  first_name: "Watts",
  last_name: "Watkins",
  email: "demo+watts@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'watts'],

  [id: 26,
  first_name: "Hil",
  last_name: "Denton",
  email: "something@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'hildawg']
]
