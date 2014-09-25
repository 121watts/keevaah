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

50.times do |i|
  @lenders << [
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    role: 'lender'
  ]
end

@borrowers = []
30.times do |i|
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


@users = [[first_name: "Jon",
last_name: "Snow",
email: "jsnow@whitewall.gov",
password: "password",
password_confirmation: "password",
role: "lender"],

[first_name: "Freddy",
last_name: "Francisco",
email: "freddyfrancisco@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Florgie",
last_name: "Smithie",
email: "florgie@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Meng",
last_name: "Smithie",
email: "meng@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Murodgul",
last_name: "Smithie",
email: "murodgul@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Wolale C",
last_name: "Group",
email: "WolaleGroup@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Akou",
last_name: "Smithie",
email: "akou@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Alejandro",
last_name: "Smithie",
email: "alejandro@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Mercedes",
last_name: "Smithie",
email: "mercedes@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "David",
last_name: "Omar",
email: "davidomar@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Tamila",
last_name: "Smithie",
email: "tamila@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Bugombwa",
last_name: "Kweyimukya Group",
email: "bugombwagroup@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Abdulqader",
last_name: "Smithie",
email: "abdulqader@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Cleydy",
last_name: "Milka",
email: "cleydymilka@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Rosa",
last_name: "Smithie",
email: "rosa@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Juliet",
last_name: "Smithie",
email: "juliet@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Sidy",
last_name: "Smithie",
email: "sidy@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Zainab",
last_name: "Smithie",
email: "zainab@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Ly",
last_name: "Smithie",
email: "ly@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Artidoro",
last_name: "Smithie",
email: "Artidoro@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Gopal",
last_name: "Smithie",
email: "Gopal@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[
first_name: "Jeff",
last_name: "Casimir",
email: "borrower@keevaah.com",
password: "password",
password_confirmation: "password",
role: "borrower",
nickname: 'j3']
]
