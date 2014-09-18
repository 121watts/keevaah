require 'rails_helper'

describe 'when viewing the loans' do

	context 'as a borrower' do

		before(:each) do
			@category = create(:category)
<<<<<<< HEAD
			@newest_category = Category.create(name: "Newest")

=======
>>>>>>> 3203a0b3139d7eec8d53de41404d8a80b66cf8a4
			@borrower = create(:borrower)
			@loan = create(:loan)
			@loan.categories << @category
			login(email: @borrower.email, password: @borrower.password)
			visit borrower_loans_path
		end

		it 'should exist' do
			expect(page.status_code).to eq 200
		end

		it 'should see existing loans' do
			expect(page).to have_content @loan.title
			expect(page).to have_content @loan.description
		end

		it 'has a link to an loan' do
			expect(page).to have_link @loan.title, href: borrower_loan_path(@loan)
		end

		it 'links successfully to loan' do
			click_link @loan.title
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content @loan.title
			expect(page).to have_content @loan.description
		end

		it 'shows the category associated with an loan' do
			visit borrower_loans_path
			expect(page).to have_content @loan.title
			expect(page).to have_content @category.name
		end

		it 'links successfully to loan' do
			click_link @loan.title
			expect(current_path).to eq(borrower_loan_path(@loan))
			expect(page).to have_content @loan.title
			expect(page).to have_content @loan.description
		end

		it 'shows the category associated with an loan' do
			visit borrower_loans_path
			expect(page).to have_content @loan.title
			expect(page).to have_content @category.name
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

<<<<<<< HEAD
		it 'can edit a category' do
			Category.create(id: 4, name: 'Test Category')
			Category.create(id: 5, name: 'Testy Cat')

=======
		it 'shows categories on edit loan page' do
			category = Category.create(id: 1, name: 'Test Category')
			category = Category.create(id: 2, name: 'Testy Category')
			@loan.category_ids = [1,2]
			visit edit_borrower_loan_path(@loan)
			expect(page).to have_content "Test Category"
			expect(page).to have_content "Testy Category"
		end

		it 'has can delete a category from loan' do
>>>>>>> 3203a0b3139d7eec8d53de41404d8a80b66cf8a4
			visit edit_borrower_loan_path(@loan)
			select("Testy Cat", :from => 'loan_categories')
			click_button("Update Loan")
			click_link("Keevahh")
			expect(current_path).to eq(root_path)
			click_link('Testy Cat')
			expect(page).to have_content 'Buy pigs'
			expect(page).to have_content "Freddy Francisco Senior is married with four children"
		end

		it 'add new loan and is seen in newest category' do
			visit new_borrower_loan_path
      fill_in "Title", with: "Buy a Sheep"
			fill_in "Description", with: "Need to buy a sheep for wool"
			fill_in "Amount", with: "800"
			fill_in "Requested by", with: "2014-09-10"
			fill_in "Repayments begin", with: "2015-09-10"
			fill_in "Monthly payment", with: "100"
			select("#{@category.name}", :from => 'loan_categories')
			click_button "Create loan"
			visit root_path
			click_link("Newest")
			expect(Loan.last.categories.find_by(name: "Newest")).to eq(@newest_category)
		end
	end
end
