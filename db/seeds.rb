require_relative './seed/borrower_seeds'
require_relative './seed/loan_seeds'
require_relative './seed/category_seeds'
require_relative './seed/contribution_seeds'

# CATEGORIES
@categories.each do |category|
  Category.create(category)
end

# USERS
@users.each do |user|
  User.create(user)
end

@lenders.each do |user|
  User.create(user)
end

# BORROWERS and LOANS
@borrowers.each do |user|
    user_ = User.create(user).first
    user_.loans.create(@loans.sample) if user_
end

@loans[0..20].each_with_index do |loan, i|
  loan_params = loan[0]
  loan = Loan.create!(loan_params)
  loan.image = URI.parse("http://s3.amazonaws.com/Keevaah_seed_photos/seed/loan_#{i + 1}.jpg")
  loan.save
end


# CONTRIBUTIONS
amounts_array = (2500..50000).step(2500).to_a
lenders = User.where(role: "lender")
100.times do
  Contribution.create(user_id: lenders.sample, loan_id: rand(50), amount: amounts_array.sample, status: "paid")
end
