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
  end

  xit 'cannot add the same contribution multiple times' do
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
    click_link 'View Contributions'
    expect(page).to have_content @loan.title
    expect(page).to have_content "$25.00"
  end

  xit 'can change the contribution amount' do
    visit loans_path
    first(:button, 'Loan Now').click
    click_link 'View Contributions'

    within('form.increment') {
      click_button '+'
    }

    within('td.quantity') { expect(page).to have_content '2' }
  end
end
