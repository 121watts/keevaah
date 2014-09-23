require 'rails_helper'

describe 'Checking out', type: :feature do
  context 'with an empty cart' do
    it 'sees an error message' do
      visit root_path
      click_on "My Cart"
      expect(page).to have_content 'Your cart is empty.'
    end
  end
end
