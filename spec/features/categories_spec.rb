require 'rails_helper'

describe 'when viewing the categories' do
	context 'as a guest' do

		before(:each) do
			@category = create(:category)
			@loan = create(:loan)
			@category.loans << @loan
			visit loans_path
		end

		it 'cannnot edit, delete, or add categories' do
			expect(page).not_to have_content('Edit')
			expect(page).not_to have_content('Delete')
			expect(page).not_to have_content('Add Category')
		end

		it "can see loans by categories" do
			expect(page).to have_content(@category.name)
			expect(page).to have_content(@loan.title)
			expect(page).to have_content(@loan.amount_in_dollars)
		end
	end
end
