require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a lender' do
		let(:loan) { Loan.create(id: 1,
														title: 'Buy a cow',
														description: 'Need to buy a milking cow for our farm',
														amount: 50000,
														requested_by: "2014-09-10 13:43:00 -0600",
														repayments_begin: "2014-09-10 13:43:00 -0600",
														monthly_payment: 100000,
														user_id: 1
														) }

		before(:each) do
			register_and_login_as_lender
      lender = User.last
			loan
      contribution = Contribution.create(user_id: lender.id, loan_id: 1, amount: 25)
			category = Category.create!(id: 1, name: "Agriculture")
      LoanCategory.create!(loan_id: 1, category_id: 1)
      loan_contribution = LoanContribution.create(contribution_id: contribution.id, loan_id: loan.id)
		end
		
		# contributions mean that less money is needed to fulfill a loan
		# can only make a contribution if the amount is less than what is owed
		# cannot contribute more than requested for loan
		# can only contribute to loans with status request

	end
end
