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

# LOANS
@loans.each do |loan|
  Loan.create(loan)
end

# CONTRIBUTIONS
100.times do Contribution.create(user_id: rand(21..30), loan_id: rand(10), status: "paid")
end
