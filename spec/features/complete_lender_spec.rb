require 'rails_helper'

describe 'lender experience' do
  context 'as a guest' do
    before(:each) do
      @category = create(:category)
      @loan     = create(:loan)
      @loan.categories << @category
      visit root_path
    end

    it 'can see a register link' do
      expect(page).to have_link 'Register'
    end

    it 'can register a new lender account' do
      register
      expect(current_path).to eq borrower_path
      expect(User.count).to eq 1
      expect(User.last.role).to eq "borrower"
    end

    it 'is logged in after registration' do
      register
      expect(page).to have_link "Logout"
    end

    it 'can see list of loan(s) on the homepage' do
      expect(page).to have_content('Buy pigs')
      expect(page).to have_content('Freddy Francisco Senior is married with four children')
      expect(page).to have_content(@loan.progress)
      expect(page).to have_content($500)
    end

    it 'can link to a details page for each loan' do
      click_link 'Buy pigs for bree...'
      expect(current_path).to eq(loan_path(@loan))
      expect(page).to have_content(@loan.title)
      expect(page).to have_content(@loan.description)
      expect(page).to have_content(@loan.requested_by)
      expect(page).to have_content(@loan.amount_in_dollars)
      expect(page).to have_content(@loan.repayments_begin)
      expect(page).to have_content(@loan.monthly_payment_in_dollars)
      expect(page).to have_content(@loan.aasm_state)
    end

    it 'can add a contibution to the cart on the homepage' do
      visit loans_path
      first(:button, 'Loan Now').click
      total_contribution = find('span.badge').text
      expect(total_contribution).to eq '1'
      expect(page).to have_content "You've added a $25.00 contribution to your cart"
    end

    it 'can add a contibution to the cart on a loans show page' do
      visit loan_path(@loan)
      first(:button, 'Loan Now').click
      total_contribution = find('span.badge').text
      expect(total_contribution).to eq '1'
      expect(page).to have_content "You've added a $25.00 contribution to your cart"
    end

    context 'with a contribution in my cart' do
      before(:each) do
        @borrower = create(:borrower)
        @loan = create(:loan, category_ids: @category.id, user_id: @borrower.id)
        @contribution = create(:contribution, loan_id: @loan.id)
        visit loans_path
        first(:button, 'Loan Now').click
        click_link 'My Cart'
      end

      it 'can view contributions in my cart' do
        expect(page).to have_content @loan.title
        expect(page).to have_content "$25.00"
      end

      xit 'can edit the contribution amount in my cart' do
        select("45", :from => 'contribution_amount')
        expect(page).to have_content "45"
      end

      it 'can remove contributions from my cart' do
        click_on 'Remove'
        expect(page).to_not have_content @loan.title
        expect(page).to have_content "Your cart is empty."
      end

      it 'must login before checking out' do
        click_on 'Checkout'
        expect(current_path).to eq login_path
      end
    end
  end

  context 'as a registered lender' do

  let(:lender) { create(:lender) }

    before(:each) do
      @category = create(:category)
      @loan     = create(:loan)
      @loan.categories << @category
      @user = create(:lender)
      @contribution = create(:contribution, user_id: @user.id, loan_id: @loan.id)
      login(email: @user.email, password: @user.password)
    end

    it 'can see list of loan(s) on the homepage' do
      expect(page).to have_content('Buy pigs')
      expect(page).to have_content('He originates from one of the northern municipalities of Chinandega')
      expect(page).to have_content(@loan.progress)
      expect(page).to have_content($500)
    end

    it 'can link to a details page for each loan' do
      click_link "Buy pigs for bree..."
      expect(current_path).to eq(loan_path(@loan))
      expect(page).to have_content(@loan.title)
      expect(page).to have_content(@loan.description)
      expect(page).to have_content(@loan.requested_by)
      expect(page).to have_content(@loan.amount_in_dollars)
      expect(page).to have_content(@loan.repayments_begin)
      expect(page).to have_content(@loan.monthly_payment_in_dollars)
      expect(page).to have_content(@loan.aasm_state)
    end

    it 'can edit account info' do
      visit contributions_path
      click_on "Edit My Profile"
      fill_in 'First name', with: 'Carlos'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_on 'Update'
      expect(current_path).to eq(contributions_path)
      expect(page).not_to have_content('Nando')
      expect(page).to have_content('Carlos')
    end

    xit 'can add a contibution to the cart on the homepage' do
      #choose contibution amount
    end

    xit 'can add a contibution to the cart on a loans show page' do
      #choose contibution amount
    end

    context 'with a contribution in my cart' do
      before(:each) do
        visit loans_path
        first(:button, 'Loan Now').click
        click_link 'My Cart'
      end

      it 'can view contributions in my cart' do
        expect(page).to have_content @loan.title
        expect(page).to have_content "$25.00"
      end

      xit 'can edit the contribution amount in my cart' do
        select("45", :from => 'contribution_amount')
        expect(page).to have_content "45"
      end

      it 'can remove contributions from my cart' do
        click_on 'Remove'
        expect(page).to_not have_content @loan.title
        expect(page).to have_content "Your cart is empty."
      end

      it 'can checkout' do
        click_on "Checkout"
        expect(current_path).to eq review_contributions_path
        expect(page).to have_content @loan.title
      end

      xit 'can enter in credit card information on checkout page' do
        click_on "Checkout"
        save_and_open_page
        fill_in "Credit Card Number", with: "4242 4242 4242 4242"
      end

      it 'can confirm order' do
        click_on "Checkout"
        click_button "Confirm and Checkout"
      end

      it 'is directed back to the homepage after making an order' do
        click_on "Checkout"
        click_button "Confirm and Checkout"
        expect(current_path).to eq root_path
      end
    end
  end
end
