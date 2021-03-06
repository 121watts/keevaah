class Contribution < ActiveRecord::Base
  include ContributionHelper

  before_create :set_default_status
  before_create :set_default_amount

  belongs_to :loan
  belongs_to :user
  belongs_to :cart

  validates_presence_of :loan_id
  validate :not_exceed_loan_amount

  def not_exceed_loan_amount
    if self.loan && self.amount
      if self.amount.to_i > self.loan.pending
        errors.add(:amount, "contribution amount cannot exceed the remaining balance of the loan")
      end
    end
  end

  def set_default_status
    self.status ||= "pending"
  end

  def set_default_amount
    self.amount ||= "2500"
  end

  def update_to_paid
    update_attribute(:status, 'paid')
  end

  def update_to_cancelled
    update_attribute(:status, 'cancelled')
  end

  def total
    total = 0
    total += self.amount.to_i
  end

  def progress
    ((self.amount.to_f / self.loan.amount.to_f) * 100).to_i
  end
end
