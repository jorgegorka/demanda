require 'rails_helper'

describe Setup::NewAccount do
  let(:user_info) {
    {
      email: 'some@user.com',
      password: 'secure-password',
      first_name: 'Some',
      last_name: 'User'
    }
  }
  let(:account_name) { 'Awesome Inc'}
  let(:new_account_service) { described_class.new(user_info, account_name) }

  describe '#create' do
    subject { new_account_service.create }

    it { is_expected.to include errors: [] }
    it { expect { new_account_service.create }.to change{ Account.count }.by(1) }
    it { expect { new_account_service.create }.to change{ User.count }.by(1) }
  end
end
