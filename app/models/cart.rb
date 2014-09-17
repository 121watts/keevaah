class Cart < ActiveRecord::Base
  has_many :cart_loans
  has_many :loans, through: :cart_loans

  def add_loan(loan)
    self.loans << loan
  end

  def remove_loan(loan)
    self.loans.delete(loan)
  end
end
