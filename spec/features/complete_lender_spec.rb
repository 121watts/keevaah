describe 'lender experience' do
  context 'as a guest' do
    it 'can see a register link' do
      visit root_path
      expect(page).to have_link 'Register'
    end

    it 'can register a new lender account' do
      register
      expect(current_path).to eq borrower_path
      expect(User.count).to eq 1
      expect(User.last.role).to eq "borrower"
    end

    xit 'is logged in after registration' do
      register
      expect(page).to have_link "Logout"
    end

    xit 'can see list of loan(s) on the homepage' do
      expect(page).to have_content(@loan.title)
      expect(page).to have_content(@loan.description)
      # expect(page).to have_content(percentage completed)
      expect(page).to have_content($500)
    end

    xit 'can link to a details page for each loan' do
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

    xit 'can add a contibution to the cart on the homepage' do
      #choose contibution amount
    end

    xit 'can add a contibution to the cart on a loans show page' do
      #choose contibution amount
    end

    context 'with a contribution in my cart' do
      xit 'can view contributions in my cart' do
      end

      xit 'can edit the contribution amount in my cart' do
      end

      xit 'can remove contributions from my cart' do
      end

      xit 'must login before checking out' do
      end
    end
  end

  context 'as a registered lender' do

  let(:lender) { create(:lender) }

    before(:each) do
      @category = create(:category)
      @loan     = create(:loan)
      @user = lender
      login(email: lender.email, password: lender.password)
    end

    xit 'can see list of loan(s) on the homepage' do
      expect(page).to have_content(@loan.title)
      expect(page).to have_content(@loan.description)
      # expect(page).to have_content(percentage completed)
      expect(page).to have_content($500)
    end

    xit 'can link to a details page for each loan' do
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

    xit 'can edit account info' do
      click_on "Edit Info"
      fill_in 'First name', with: 'Carlos'
      fill_in 'Password', with: '123'
      fill_in 'Password confirmation', with: '123'
      click_on 'Update'
      expect(current_path).to eq(borrower_path)
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
      xit 'can view contributions in my cart' do
      end

      xit 'can edit the contribution amount in my cart' do
      end

      xit 'can remove contributions from my cart' do
      end

      xit 'can checkout' do
      end

      xit 'can only confirm contribution amounts in checkout' do
      end

      xit 'can enter in credit card information on checkout page' do
      end

      xit 'can confirm order' do
      end

      xit 'can view order confirmation' do
      end

      xit 'is directed back to the homepage after making an order' do
      end
    end
  end
end
