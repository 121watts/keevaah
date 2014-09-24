require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a guest' do
		before(:each) do
			@loan = create(:loan, title: "Loan 1")
		end

		#put test for seeing all loans here
	end

	context 'as a borrower' do

		before(:each) do
			@category = create(:category)
			@newest_category = Category.create(name: "Newest")
			@borrower = create(:borrower)
			@loan = create(:loan)
			@loan.categories << @category
			login(email: @borrower.email, password: @borrower.password)
			visit borrower_path
		end

		it 'should exist' do
			expect(page.status_code).to eq 200
		end

		it 'should see existing loans' do
			expect(page).to have_content @loan.title
		end

		it 'has a link to an loan' do
			expect(page).to have_link @loan.title, href: borrower_loan_path(@loan)
		end

		it 'links successfully to loan' do
			click_link @loan.title
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content @loan.title
		end

		it 'links successfully to loan' do
			click_link @loan.title
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content @loan.title
		end

		it 'can create a new loan' do
			visit new_borrower_loan_path
			fill_in "loan[title]", with: "Buy a Sheep"
			fill_in 'loan[description]', with: "Need to buy a sheep for wool"
			fill_in "loan[amount]", with: "800"
			fill_in "loan[requested_by]", with: "2014-09-10"
			fill_in "loan[repayments_begin]", with: "2015-09-10"
			fill_in "loan[monthly_payment]", with: "100"
			select("#{@category.name}", :from => 'loan_categories')
			click_button "Submit"
			expect(current_path).to eq(borrower_path)
			expect(page).to have_content 'Buy a Sheep'
			click_link("Keevahh")
			expect(current_path).to eq(root_path)
			expect(page).to have_content 'Buy a Sheep'
			expect(page).to have_content "Need to buy a sheep for wool"
		end

		it	'cannot create an loan without a title' do
			visit new_borrower_loan_path
			fill_in "loan[title]", with: ""
			fill_in "loan[description]", with: "Need to buy a sheep for wool"
			fill_in "loan[amount]", with: "800"
			fill_in "loan[requested_by]", with: "2014-09-10"
			fill_in "loan[repayments_begin]", with: "2015-09-10"
			fill_in "loan[monthly_payment]", with: "100"
			click_button "Submit"
			expect(page).to have_content 'blank'
		end

		it'cannot create an loan without a description' do
			visit new_borrower_loan_path
			fill_in "loan[title]", with: "Buy a Sheep"
			fill_in "loan[description]", with: ""
			fill_in "loan[amount]", with: "800"
			fill_in "loan[requested_by]", with: "2014-09-10"
			fill_in "loan[repayments_begin]", with: "2015-09-10"
			fill_in "loan[monthly_payment]", with: "100"
			click_button "Submit"
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without an amount' do
			visit new_borrower_loan_path
			fill_in "loan[title]", with: "Buy a Sheep"
			fill_in "loan[description]", with: "Need to buy a sheep for wool"
			fill_in "loan[amount]", with: ""
			fill_in "loan[requested_by]", with: "2014-09-10"
			fill_in "loan[repayments_begin]", with: "2015-09-10"
			fill_in "loan[monthly_payment]", with: "100"
			click_button "Submit"
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without a requested by date' do
			visit new_borrower_loan_path
			fill_in "loan[title]", with: "Buy a Sheep"
			fill_in "loan[description]", with: "Need to buy a sheep for wool"
			fill_in "loan[amount]", with: ""
			fill_in "loan[requested_by]", with: ""
			fill_in "loan[repayments_begin]", with: "2015-09-10"
			fill_in "loan[monthly_payment]", with: "100"
			click_button "Submit"
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without a repayments begin date' do
			visit new_borrower_loan_path
			fill_in "loan[title]", with: "Buy a Sheep"
			fill_in "loan[description]", with: "Need to buy a sheep for wool"
			fill_in "loan[amount]", with: ""
			fill_in "loan[requested_by]", with: "2014-09-10"
			fill_in "loan[repayments_begin]", with: ""
			fill_in "loan[monthly_payment]", with: "100"
			click_button "Submit"
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without a monthly payment' do
			visit new_borrower_loan_path
			fill_in "loan[title]", with: "Buy a Sheep"
			fill_in "loan[description]", with: "Need to buy a sheep for wool"
			fill_in "loan[amount]", with: ""
			fill_in "loan[requested_by]", with: "2014-09-10"
			fill_in "loan[repayments_begin]", with: "2015-09-10"
			fill_in "loan[monthly_payment]", with: ""
			click_button "Submit"
			expect(page).to have_content 'blank'
		end

		it 'add new loan and is seen in newest category' do
			visit new_borrower_loan_path
      fill_in "loan[title]", with: "Buy a Sheep"
			fill_in "loan[description]", with: "Need to buy a sheep for wool"
			fill_in "loan[amount]", with: "800"
			fill_in "loan[requested_by]", with: "2014-09-10"
			fill_in "loan[repayments_begin]", with: "2015-09-10"
			fill_in "loan[monthly_payment]", with: "100"
			select("#{@category.name}", :from => 'loan_categories')
			click_button "Submit"
			visit root_path
			click_link('Newest')
			expect(page).to have_content 'Buy a Sheep'
		end
	end
end
