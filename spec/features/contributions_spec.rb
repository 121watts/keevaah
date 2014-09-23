require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a lender' do
		before(:each) do
      @lender = create(:lender)
			@borrower = create(:borrower)
			@category = create(:category)
			@loan = create(:loan, category_ids: @category.id, user_id: @borrower.id)
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

		it 'can see the contributions they have made' do
			click_on "My Profile"
			expect(page).to have_content("My Cart")
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

    it 'can see loan name from contribution page' do
			click_on "My Profile"
      expect(page).to have_content('Buy pigs')
    end

    it 'can see borrower name, and loan deets on details page' do
			click_on "My Profile"
      click_link "#{@loan.title}"
			expect(page).to have_content(@loan.user.first_name)
      expect(page).to have_content("$#{@loan.amount/100}")
      expect(page).to have_content(@loan.title)
			expect(page).to have_content(@loan.description)
    end

		it 'can cancel a contribution' do
			click_on "My Profile"
			expect(page).to have_content('Buy pigs')
			first(:link, 'Cancel').click
			expect(page).to have_content('Cancelled')
		end
  end
end
