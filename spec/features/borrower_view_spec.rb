require 'rails_helper'

describe 'When viewing the borrower dashboard' do
	context "as a borrower" do

		before(:each) do
			register_and_login_as_borrower
		end

		it "has a dashboard with loans specific to that borrower" do
			visit borrower_path
<<<<<<< HEAD
			expect(page).to have_content("Gen Casagrande D ashboard")
=======
			expect(page).to have_content("Gen Casagrande's Dashboard")
>>>>>>> d470add28f34d48da4b06f8b5649c09860a40bc1
		end

		it "has a link to create a loan" do
			visit borrower_path
			expect(page).to have_link("Apply")
		end

		it "has the borrower's profile" do
			visit borrower_path
			expect(page).to have_content("Gen")
			expect(page).to have_content("Casagrande")
		end
	end

end
