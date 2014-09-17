require 'rails_helper'

RSpec.describe Contribution, type: :model do
  let (:contribution) {Contribution.create(user_id: 1, loan_id: 1)}

  it 'is valid' do
    expect(contribution).to be_valid
  end

  it { should validate_presence_of(:user_id) }

  it { should validate_presence_of(:loan_id) }

  it 'should have default values of pending and $25.00' do
    expect(contribution.status).to eq('pending')
    expect(contribution.amount).to eq('2500')
  end

  it 'can update the contribtion status to paid' do
    contribution.update_to_paid
    expect(contribution.status).to eq('paid')
  end

  it 'can update status to paid' do
    contribution.update_to_cancelled
    expect(contribution.status).to eq('cancelled')
  end

  
end

# contributions mean that less money is needed to fulfill a loan
  # can only make a contribution if the amount is less than what is owed
  # cannot contribute more than requested for loan
  # can only contribute to loans with status request
