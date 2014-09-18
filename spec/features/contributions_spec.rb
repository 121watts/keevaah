require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a lender' do
		before(:each) do
      @lender = create(:lender)
			@category = create(:category)
			@loan = create(:loan, category_ids: @category.id)
      @contribution = create(:contribution, user_id: @lender.id, loan_id: @loan.id)
			login(email: @lender.email, password: @lender.password )
		end

		# contributions mean that less money is needed to fulfill a loan
		# can only make a contribution if the amount is less than what is owed
		# cannot contribute more than requested for loan
		# can only contribute to loans with status request

		it 'can choose a loan and make a contribution to it' do
			visit loans_path
			click_on "Loan Now"
		end

		it 'can see a total for all contribution' do
			class DummyClass
			end
			dummy = DummyClass.new
			dummy.extend(ContributionHelper)
			dummy.stub(:current_user) { User.new(id: 1) }
			3.times do Contribution.create(user_id: 1, loan_id: 2)
			end
			expect(dummy.total).to eq 10000
		end

    xit 'can see borrower name from contribution page' do
      expect(page).to have_content('your dad')
    end

    xit 'can see borrower name, and loan deets on details page' do
      click_link 'Details'
      expect(page).to have_content(loan.borrower.name)
      expect(page).to have_content(loan.amount)
      expect(page).to have_content(loan.title)
      expect(page).to have_content(loan.description)
    end
  end
end
