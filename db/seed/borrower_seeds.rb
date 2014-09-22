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

@borrowers <<
  [
  first_name: "Jeff",
  last_name: "Casimir",
  email: "demo+jeff@jumpstartlab.com",
  password: "password",
  password_confirmation: "password",
  role: "borrower",
  nickname: 'j3']
