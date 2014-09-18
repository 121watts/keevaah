require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a borrower' do

		before(:each) do
			register_and_login_as_borrower
			@borrower = User.last
			@category = Category.create(id: 3, name: "Agriculture")
			@loan = Loan.create(title: 'Buy a cow',
															description: 'Need to buy a milking cow for our farm',
															amount: 50000,
															requested_by: "2014-09-10 13:43:00 -0600",
															repayments_begin: "2014-09-10 13:43:00 -0600",
															monthly_payment: 1000,
															user_id: @borrower.id
															)
			visit borrower_loans_path
		end

		it 'should exist' do
			expect(page.status_code).to eq 200
		end

		it 'should see existing loans' do
			expect(page).to have_content 'Buy a cow'
			expect(page).to have_content 'Need to buy a milking cow for our farm'
			expect(page).to have_content '$500.00'
		end

		it 'has a link to an loan' do
			expect(page).to have_link 'Buy a cow', href: borrower_loan_path(@loan)
		end

		it 'links successfully to loan' do
			click_link 'Buy a cow'
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content 'Buy a cow'
			expect(page).to have_content 'Need to buy a milking cow for our farm'
		end

		it 'shows the category associated with an loan' do
			@loan.categories << @category
			@category.loans << @loan
			visit borrower_loans_path
			expect(page).to have_content "Buy a cow"
			expect(page).to have_content "Agriculture"
		end

		it 'links successfully to loan' do
			click_link 'Buy a cow'
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content 'Buy a cow'
			expect(page).to have_content 'Need to buy a milking cow for our farm'
		end

		it 'shows the category associated with an loan' do
			@loan.categories << @category
			@category.loans << @loan
			visit borrower_loans_path
			expect(page).to have_content "Buy a cow"
			expect(page).to have_content "Agriculture"
		end

		it 'can create a new loan' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Buy a Sheep"
			fill_in "Description", with: "Need to buy a sheep for wool"
			fill_in "Amount", with: "800"
			fill_in "Requested by", with: "2014-09-10"
			fill_in "Repayments begin", with: "2015-09-10"
			fill_in "Monthly payment", with: "100"
			select("#{@category.name}", :from => 'loan_categories')
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'Buy a Sheep'
			expect(page).to have_content "Need to buy a sheep for wool"
			click_link("Keevahh")
			expect(current_path).to eq(root_path)
			expect(page).to have_content 'Buy a Sheep'
			expect(page).to have_content "Need to buy a sheep for wool"
		end

		it	'cannot create an loan without a title' do
			visit new_borrower_loan_path
			fill_in "Title", with: ""
			fill_in "Description", with: "Need to buy a sheep for wool"
			fill_in "Amount", with: "800"
			fill_in "Requested by", with: "2014-09-10"
			fill_in "Repayments begin", with: "2015-09-10"
			fill_in "Monthly payment", with: "100"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		it'cannot create an loan without a description' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Buy a Sheep"
			fill_in "Description", with: ""
			fill_in "Amount", with: "800"
			fill_in "Requested by", with: "2014-09-10"
			fill_in "Repayments begin", with: "2015-09-10"
			fill_in "Monthly payment", with: "100"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without an amount' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Buy a Sheep"
			fill_in "Description", with: "Need to buy a sheep for wool"
			fill_in "Amount", with: ""
			fill_in "Requested by", with: "2014-09-10"
			fill_in "Repayments begin", with: "2015-09-10"
			fill_in "Monthly payment", with: "100"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without a requested by date' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Buy a Sheep"
			fill_in "Description", with: "Need to buy a sheep for wool"
			fill_in "Amount", with: ""
			fill_in "Requested by", with: ""
			fill_in "Repayments begin", with: "2015-09-10"
			fill_in "Monthly payment", with: "100"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without a repayments begin date' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Buy a Sheep"
			fill_in "Description", with: "Need to buy a sheep for wool"
			fill_in "Amount", with: ""
			fill_in "Requested by", with: "2014-09-10"
			fill_in "Repayments begin", with: ""
			fill_in "Monthly payment", with: "100"
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end

		it	'cannot create an loan without a monthly payment' do
			visit new_borrower_loan_path
			fill_in "Title", with: "Buy a Sheep"
			fill_in "Description", with: "Need to buy a sheep for wool"
			fill_in "Amount", with: ""
			fill_in "Requested by", with: "2014-09-10"
			fill_in "Repayments begin", with: "2015-09-10"
			fill_in "Monthly payment", with: ""
			click_button "Create loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'blank'
		end


		it 'can update an loan' do
			visit edit_borrower_loan_path(@loan)
			fill_in "Title", with: "Fancy New Donut"
			fill_in "Description", with: "It's pretty fancy"
			fill_in "Amount", with: "800"
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).to have_content 'Fancy New Donut'
			expect(page).to have_content "It's pretty fancy"
			expect(page).not_to have_content 'OMG Donut'
			expect(page).not_to have_content "Just like, wow."
		end

		it 'cannot update a loan without a title' do
			visit edit_borrower_loan_path(@loan)
			fill_in "Title", with: ""
			fill_in "Description", with: "It's pretty fancy"
			fill_in "Amount", with: "800"
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content 'blank'
		end

		it 'cannot update a loan without a description' do
			visit edit_borrower_loan_path(@loan)
			fill_in "Title", with: "Poopers"
			fill_in "Description", with: ""
			fill_in "Amount", with: "800"
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content 'blank'
		end

		it 'cannot update a loan without a Amount' do
			visit edit_borrower_loan_path(@loan)
			fill_in "Title", with: "Poopers"
			fill_in "Description", with: "Tasty"
			fill_in "Amount", with: ""
			click_button "Update Loan"
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content 'blank'
		end

		it 'can delete an loan' do
			visit borrower_loan_path(@loan)
			click_link "Delete"
			expect(current_path).to eq(borrower_loans_path)
			expect(page).not_to have_content "Buy a pig"
			expect(page).not_to have_content "Need to buy a pig for ham"
		end

		it 'can edit a category' do
			Category.create(id: 4, name: 'Test Category')
			Category.create(id: 5, name: 'Testy Cat')

			visit edit_borrower_loan_path(@loan)
			select("Testy Cat", :from => 'loan_categories')
			click_button("Update Loan")
			click_link("Keevahh")
			expect(current_path).to eq(root_path)
			save_and_open_page
			click_link('Testy Cat')
			expect(page).to have_content 'Buy a cow'
			expect(page).to have_content "Need to buy a milking cow for our farm"
		end
	end
end
