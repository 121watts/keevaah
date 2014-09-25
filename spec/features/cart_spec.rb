require 'rails_helper'

describe 'Shopping Contributions', type: :feature do
  before(:each) do
    @category = create(:category)
    @loan = create(:loan)
    @category.loans << @loan
  end

  it 'can add a contribution to a cart' do
    visit loans_path
    first(:button, 'Loan Now').click
    total_contribution = find('span.badge').text
    expect(total_contribution).to eq '1'
    expect(page).to have_content "You've added a $25.00 contribution to your cart"
  end

  it 'cannot add the same contribution multiple times' do
    visit loans_path
    first(:button, 'Loan Now').click
    first(:button, 'Loan Now').click
    total_loans = find('span.badge').text
    expect(total_loans).to eq '1'
  end

  it 'cannot add an loan that are disabled' do
    loan = Loan.last
    loan.fulfill!
    visit loans_path
    expect(page).not_to have_content "#{loan.description}"
  end

  it 'can view the Contributions' do
    visit loans_path
    first(:button, 'Loan Now').click
    click_link 'My Cart'
    expect(page).to have_content @loan.title
    expect(page).to have_content "$25.00"
  end

  it 'can delete contributions from the cart' do
    visit loans_path
    first(:button, 'Loan Now').click
    click_link 'My Cart'
    click_on 'Remove'
    expect(page).to_not have_content @loan.title
    expect(page).to have_content "Your cart is empty."
  end
end
