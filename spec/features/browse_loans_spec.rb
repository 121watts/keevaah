require 'rails_helper'

describe 'when viewing the loan requests' do
  context 'as a guest' do

    before(:each) do
      @category = Category.create(id: 1, name: "Ag, bro")
      @loan = create(:loan, title: "Excitement")
      @loan2 = create(:loan, title: "Loan 2")
      @category.loans << @loan
      @category.loans << @loan2

      visit loans_path
    end

    it 'should exist' do
      expect(page.status_code).to eq 200
    end

    it 'should see all the loans by borrower' do
      expect(current_path).to eq(loans_path)
      expect(page).to have_content @loan.title
      expect(page).to have_content @loan2.title
    end

    it 'has a link to a borrower' do
      expect(page).to have_link "#{@loan.title}", href: loan_path(@loan)
    end

    it 'links successfully to the loan' do
      click_link "#{@loan.title}"
      expect(current_path).to eq(loan_path(@loan))
      expect(page).to have_content "#{@loan.title}"
      expect(page).to_not have_content "#{@loan2.title}"
    end

    it "lists remaining dollars until loan fulfillment" do
      expect(page).to_not have_content(@loan.amount)
      contribution = create(:contribution, loan_id: @loan.id, amount: 10000, status: "paid")
      visit loans_path
      expect(page).to have_content((@loan.amount-10000)/100)
    end

    it "lists remaining days until loan requested_by date" do
      expect(page).to have_content((@loan.requested_by - Date.today).to_i)
    end
  end
end
