class Contribution < ActiveRecord::Base
  before_create :set_default_status
  before_create :set_default_amount

  belongs_to :loan
  belongs_to :user

  validates_presence_of :loan_id
  validates_presence_of :user_id


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

end
