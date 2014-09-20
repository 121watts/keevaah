@lenders = [
  [
  first_name: "Jon",
  last_name: "Snow",
  email: "jsnow@whitewall.gov",
  password: "password",
  password_confirmation: "password",
  role: "lender"],

  [
  first_name: "Lender",
  last_name: "McLender",
  email: "lender@keevaah.com",
  password: "password",
  password_confirmation: "password",
  role: "lender",
  nickname: 'McLender']
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
  [
  first_name: "Jeff",
  last_name: "Casimir",
  email: "demo+jeff@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'j3'],

  [
  first_name: "Jorge",
  last_name: "Tellez",
  email: "demo+jorge@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'novohispano'],

  [
  first_name: "Josh",
  last_name: "Cheek",
  email: "demo+josh@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'josh'],

  [
  first_name: "Watts",
  last_name: "Watkins",
  email: "demo+watts@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'watts'],

  [
  first_name: "Hil",
  last_name: "Denton",
  email: "something@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  nickname: 'hildawg']
]
