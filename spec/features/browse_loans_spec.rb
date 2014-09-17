require 'rails_helper'

describe 'when viewing the loan requests' do

 context 'as a guest' do

   before(:each) do
     @category = Category.create(id: 1, name: "Ag, bro")
     @loan = Loan.create(id: 1,
                           title: 'Buy a cow',
                           description: 'Need to buy a milking cow for our farm',
                           amount: 50000,
                           requested_by: "2014-09-10 13:43:00 -0600",
                           repayments_begin: "2014-09-10 13:43:00 -0600",
                           monthly_payment: 1000,
                           user_id: 1
                           )
     @loan2 = Loan.create(id: 2,
                           title: 'Buy another cow',
                           description: 'Need to buy another milking cow for our farm',
                           amount: 50000,
                           requested_by: "2014-09-10 13:43:00 -0600",
                           repayments_begin: "2014-09-10 13:43:00 -0600",
                           monthly_payment: 1000,
                           user_id: 2
                           )
     @loan_category = LoanCategory.create(loan_id: 1, category_id: 1)

     @loan_category2 = LoanCategory.create(loan_id: 2, category_id: 1)

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
 end
end
