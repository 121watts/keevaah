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
  [
  first_name: "Jeff",
  last_name: "Casimir",
  email: "borrower@keevaah.com",
  password: "password",
  password_confirmation: "password",
  role: "borrower",
  nickname: 'j3']

@users = [[first_name: "Jon",
last_name: "Snow",
email: "jsnow@whitewall.gov",
password: "password",
password_confirmation: "password",
role: "lender"],

[first_name: "Freddy",
last_name: "Francisco",
email: "freddyfrancisco@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Florgie",
last_name: "Lastname",
email: "florgie@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Meng",
last_name: "Lastname",
email: "meng@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Murodgul",
last_name: "Lastname",
email: "murodgul@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Wolale C",
last_name: "Group",
email: "WolaleGroup@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Akou",
last_name: "Lastname",
email: "akou@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Alejandro",
last_name: "Lastname",
email: "alejandro@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Mercedes",
last_name: "Lastname",
email: "mercedes@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "David",
last_name: "Omar",
email: "davidomar@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Tamila",
last_name: "Lastname",
email: "tamila@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Bugombwa",
last_name: "Kweyimukya Group",
email: "bugombwagroup@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Abdulqader",
last_name: "Lastname",
email: "abdulqader@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Cleydy",
last_name: "Milka",
email: "cleydymilka@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Rosa",
last_name: "Lastname",
email: "rosa@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Juliet",
last_name: "Lastname",
email: "juliet@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Sidy",
last_name: "Lastname",
email: "sidy@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Zainab",
last_name: "Lastname",
email: "zainab@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Ly",
last_name: "Lastname",
email: "ly@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Artidoro",
last_name: "Lastname",
email: "Artidoro@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"],

[first_name: "Gopal",
last_name: "Lastname",
email: "Gopal@jumpstartlab.com",
password: "password",
password_confirmation: "password",
role: "borrower"]]
