class Cart < ActiveRecord::Base
  has_many :cart_contributions
  has_many :contributions, through: :cart_contributions

  def add_contribution(contribution)
    if validate_contribution?(contribution)
      self.contributions << contribution 
    end
  end

  def remove_contribution(contribution)
    self.contributions.delete(contribution)
  end

  def validate_contribution?(pending_contribution)
    contribution_loans = self.contributions.map do |contribution|
      contribution.loan.id
    end
    !contribution_loans.include?(pending_contribution.loan.id)
  end

  def total
    total = contributions.inject(0) { |i, contribution| i += contribution.amount.to_i }
    total/100
  end
end
