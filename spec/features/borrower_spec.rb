require 'rails_helper'
include ApplicationHelper

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

    it 'cannot register without an email' do
      register(email: nil)
      expect(page).to have_content "Email can't be blank"
    end

    it 'cannot register with an email already registersed' do
      register
      click_on 'Logout'
      register
      expect(page).to have_content "Email has already been taken"
    end

    it 'cannot register with an invalid email address' do
      register(email: '^$%^%#$@#$^%$^.com')
      expect(page).to have_content "Email is invalid"
    end

    it 'cannot register without a password' do
      register(password: nil)
      expect(page).to have_content "Password can't be blank"
    end

    it 'cannot register without a password confirmation' do
      register(password_confirmation: nil)
      expect(page).to have_content "Password confirmation can't be blank"
    end

    it 'cannnot register when passwords do not match' do
      register(password: '123', password_confirmation: '1234')
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    it 'stays logged in after registration' do
      register
      expect(page).to have_link "Logout"
    end

    it 'gives me confirmation after successful registration' do
      register
      expect(page).to have_content "Registration successful"
    end

    it 'cannot backdoor to borrower pages' do
      visit borrower_path
      expect(current_path).to eq(login_path)
    end

    it 'cannot register with a nickname of 1 character or greater than 32 characters' do
      visit root_path
      click_link 'Register'
      register(nickname: 'o')
      expect(page).to have_content('1 error prohibited this user from being saved')
    end
  end

  context 'as a registered borrower' do

  let(:borrower) { create(:borrower) }
  let(:contribution) { create(:contribution) }

    before(:each) do
      @category = create(:category)
      @loan = create(:loan)
      @loan.categories << @category
      @user = borrower
      @user.loans << @loan
      login(email: borrower.email, password: borrower.password)
    end

    it "has a borrower dashboard" do
      expect(current_path).to eq(borrower_path)
      expect(page).to have_content("Dashboard")
      expect(page).to have_content("Apply")
    end

    it 'can view their loans' do
      click_on "My Dashboard"
      expect(page).to have_content "Loans"
      expect(page).to have_content "Title"
      expect(page).to have_content "Percent"
    end

    it 'can view date joined, first name, last name, email, and nickname' do
      click_on "Logout"
      login(email: borrower.email, password: borrower.password)
      expect(page).to have_content(borrower.first_name)
      expect(page).to have_content(borrower.last_name)
    end

    it 'can view edit personal info' do
      click_on "Edit Profile"
      expect(current_path).to eq edit_user_path(@user)
      expect(page).to have_button "Update"
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

    it 'can see list of their loan(s) on the borrower dashboard' do
      expect(page).to have_content(@loan.title)
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
    end

    it 'cannot add a nickame of 1 characer' do
      click_on 'Edit Profile'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      fill_in 'Nickname', with: 'a'
      click_on 'Update'
      expect(current_path).to eq user_path(@user)
    end

    it 'cannot add a nickame of > 32 characers' do
      click_on 'Edit Profile'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      fill_in 'Nickname', with: (0..33).map{'a'}.join
      click_on 'Update'
      expect(current_path).to eq user_path(@user)
    end
  end
end
