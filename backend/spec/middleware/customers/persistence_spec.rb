require 'rails_helper'

describe Customers::Persistence do
  let(:account) { create(:account) }
  let!(:language) { create(:language, account: account) }
  let(:name) { 'Toundra' }
  let(:email) { 'toundra@progrock.com' }
  let(:language_id) { language.uuid }
  let(:password) { 'cant-be-cracked' }
  let(:current_user) { }
  let(:params) { { name: name, email: email, password: password, language_id: language_id } }
  let(:customer_persistence) { described_class.new(account, current_user) }

  describe '.create' do
    subject(:create_customer) { customer_persistence.create(params) }

    context 'when there is no active user' do
      it { expect { create_customer }.to change{ Customer.count }.by(1) }
      it { expect { create_customer }.to change{ User.count }.by(1) }
    end

    context 'when there is an active user' do
      let(:current_user) { create(:user, account: account) }

      it { expect(create_customer).to eql current_user.customer }
    end

    context 'when there is no language' do
      let(:language_id) {}

      it { expect(create_customer.language).to eql language }
    end
  end
end