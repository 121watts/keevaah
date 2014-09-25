require 'rails_helper'

describe 'Checking out', type: :feature do
  context 'with an empty cart' do
    it 'sees an error message' do
      visit root_path
      click_on "My Cart"
      expect(page).to have_content 'Your cart is empty.'
    end
  end
  context 'with things in my cart' do

    before(:each) do
      category = create(:category)
      loan = create(:loan)
      category.loans << loan
      @lender = create(:lender)
    end

    it 'redirects me to the same page i was on after logginging' do
      visit root_path
      click_on "Loan Now"
      click_on "My Cart"
      expect(current_path).to eq cart_path
      click_on "Checkout"
      fill_in('Email', :with => @lender.email)
      fill_in('Password', :with => 'password')
      click_button "Login"
      expect(current_path).to eq review_contributions_path
    end

    it "can check out and get a confirmation page" do
      login(email: @lender.email, password: @lender.password)
      visit root_path
      click_on "Loan Now"
      click_on "My Cart"
      click_on "Checkout"
      click_on "Checkout"
      expect(current_path).to eq(confirmation_contributions_path)
    end
  end
end
