require 'rails_helper'

describe 'Shopping Contributions', type: :feature do
  before(:each) do
    category = Category.create!(name: 'Agriculture')
    category.loans.create!(id: 1,
                            title: 'Buy a cow',
                            description: 'Need to buy a milking cow for our farm',
                            amount: 50000,
                            requested_by: "2014-09-10",
                            repayments_begin: "2014-09-10",
                            monthly_payment: 1000
                            )
  end

  it 'can add a contribution to a cart' do
    visit categories_path
    first(:button, 'Loan Now').click
    total_contribution = find('span.badge').text
    expect(total_contribution).to eq '1'
  end

  xit 'cannot add the same contribution multiple times' do
    # i cannot figure out how to change an attribut with any kind of presisitence
    visit categories_path
    first(:button, 'Loan Now').click
    expect(page).to_not have_content('Loan Now')
    expect(page).to have_content('Checkout')
    total_loans = find('span.badge').text
    expect(total_loans).to eq '1'
  end

  it 'cannot add an loan that do not exist' do
    visit categories_path
    Loan.destroy_all
    first(:button, 'Loan Now').click
    expect(page).to have_content 'That loan is no longer available.'
  end

  xit 'cannot add an loan that are disabled' do
    visit categories_path
    Loan.first.fulfill
    first(:button, 'Loan Now').click
    expect(page).to have_content 'That loan is no longer available.'
  end

  it 'can view the Contributions' do
    visit categories_path
    first(:button, 'Loan Now').click
    click_link 'View Contributions'
    expect(page).to have_content 'Buy a cow'
    expect(page).to have_content '$25.00'
  end

  it 'can remove an loan from the Contributions' do
    visit categories_path
    first(:button, 'Loan Now').click
    click_link 'View Contributions'
    click_on 'Remove'
    expect(page).to have_content "You will not contribute to 'Buy a cow'."
    expect(page).to_not have_content '500.00'
  end

  xit 'can change the contribution amount' do
    visit categories_path
    first(:button, 'Loan Now').click
    click_link 'View Contributions'

    within('form.increment') {
      click_button '+'
    }

    within('td.quantity') { expect(page).to have_content '2' }
  end
end
