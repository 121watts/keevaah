require 'rails_helper'

describe 'borrower experience' do
  context 'as a guest' do
    it 'can see a register link' do
      visit root_path
      expect(page).to have_link 'Register'
    end

    it 'can register a new borrower account' do
      register
      expect(current_path).to eq borrower_path
      expect(User.count).to eq 1
      expect(User.last.role).to eq "borrower"
    end

    it 'is logged in after registration' do
      register
      expect(page).to have_link "Logout"
    end
  end

context 'as a registered borrower without a loan' do

  let(:borrower) { create(:borrower) }

    before(:each) do
      @category = create(:category)
      @user = borrower
      login(email: borrower.email, password: borrower.password)
    end

    it 'can create a loan' do
      click_link "Apply For A New Loan"
			fill_in "loan[title]", with: "Buy a Sheep"
			fill_in "loan[description]", with: "Need to buy a sheep for wool"
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

    it 'can edit account info' do
      click_on "Edit Profile"
      fill_in 'First name', with: 'Carlos'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_on 'Update'
      expect(current_path).to eq(borrower_path)
      expect(page).not_to have_content('Nando')
      expect(page).to have_content('Carlos')
    end

    context 'after creating a loan' do
      before(:each) do
        @loan = create(:loan)
        visit borrower_path
      end

      it 'can see created loans on the borrower dashboard' do
        expect(page).to have_content(@loan.title)
        expect(page).to have_content(@loan.progress)
        expect(page).to have_content($500)
      end

      it 'can link to a details page for created loan' do
        click_link "#{@loan.title}"
        expect(current_path).to eq(borrower_loan_path(@loan))
        expect(page).to have_content(@loan.title)
        expect(page).to have_content(@loan.description)
        expect(page).to have_content(@loan.requested_by)
        expect(page).to have_content(@loan.amount_in_dollars)
        expect(page).to have_content(@loan.repayments_begin)
        expect(page).to have_content(@loan.monthly_payment_in_dollars)
        expect(page).to have_content(@loan.aasm_state)
      end

      it 'can cancel a loan request' do
        click_link("Cancel")
        expect(page).not_to have_content 'Buy pigs for breeding and then selling'
      end
    end
  end
end

context 'as a registered borrower with a loan' do

let(:borrower) { create(:borrower) }

  before(:each) do
    @category = create(:category)
    @loan     = create(:loan)
    @user = borrower
    login(email: borrower.email, password: borrower.password)
  end

  it 'can see list of thier loan(s) on the borrower dashboard' do
    expect(page).to have_content(@loan.title)
    expect(page).to have_content(@loan.progress)
    expect(page).to have_content($500)
  end

  it 'can view loans by status' do
    @loan = create(:loan)
    expect(page).to have_content(@loan.aasm_state.capitalize)
    expect(page).to have_content(@loan.title)
    expect(page).to have_content(@loan.progress)
    expect(page).to have_content($500)
  end

  it 'can link to a details page for each loan' do
    click_link "#{@loan.title}"
    expect(current_path).to eq(borrower_loan_path(@loan))
    expect(page).to have_content(@loan.title)
    expect(page).to have_content(@loan.description)
    expect(page).to have_content(@loan.requested_by)
    expect(page).to have_content(@loan.amount_in_dollars)
    expect(page).to have_content(@loan.repayments_begin)
    expect(page).to have_content(@loan.monthly_payment_in_dollars)
    # expect(page).to have_content(status)
  end

  it 'cannot cancel a fulfilled loan' do
    click_link("Cancel")
    expect(page).not_to have_content "You cannot cancel a loan with contributions"
    expect(page).not_to have_content 'Buy pigs for breeding and then selling'
  end

  it 'can edit account info' do
    click_on "Edit Profile"
    fill_in 'First name', with: 'Carlos'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_on 'Update'
    expect(current_path).to eq(borrower_path)
    expect(page).not_to have_content('Nando')
    expect(page).to have_content('Carlos')
  end
end
