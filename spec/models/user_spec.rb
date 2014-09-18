require 'rails_helper'

describe User, type: :model do

  let(:user) { create(:borrower) }

  it 'is valid' do
    expect(user).to be_valid
  end

  it { should validate_presence_of(:email) }

  it { should validate_presence_of(:first_name) }

  it { should validate_presence_of(:last_name) }

  it { should validate_presence_of(:password) }

  it { should validate_presence_of(:password_confirmation) }

  it { should allow_value('me@example.com', 'yourmom123@aol.com').for :email }

  it { should_not allow_value('sdaf*!@~=-0>!', nil, '').for :email }

  it { should validate_confirmation_of(:password) }

  it { should validate_uniqueness_of(:email) }

  it { should have_secure_password }

  it { should validate_presence_of(:role)}

  it { should allow_value(nil).for(:nickname) }

  it { should ensure_length_of(:nickname).is_at_most(32) }

  it { should ensure_length_of(:nickname).is_at_least(2) }

end
