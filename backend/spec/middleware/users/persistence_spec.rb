require 'rails_helper'

describe Users::Persistence do
  let(:account) { create(:account) }
  let!(:language) { create(:language, account: account) }
  let(:name) { 'Toundra' }
  let(:email) { 'toundra@progrock.com' }
  let(:language_id) { language.uuid }
  let(:password) { 'cant-be-cracked' }
  let(:current_user) {}
  let(:params) { { name: name, email: email, password: password, language_id: language_id } }
  let(:user_persistence) { described_class.new(account, current_user) }

  describe '.create' do
    subject(:create_user) { user_persistence.create(params) }

    context 'when there is no active user' do
      it { expect { create_user }.to change { User.count }.by(1) }
      it { expect { create_user }.to change { User.count }.by(1) }
    end

    context 'when there is an active user' do
      let(:current_user) { create(:user, account: account) }

      it { expect(create_user).to eql current_user }
    end

    it { expect(create_user.language).to eql language }

    context 'when there is no language' do
      let(:language_id) {}

      it { expect(create_user.language).to be_nil }
    end
  end

  describe '.update' do
    let(:current_user) { create(:user, account: account) }
    let(:params) { { name: 'Seemannsgarn by Tanzwut', phone: '987654321' } }

    subject { user_persistence.update(params) }

    it { expect(subject.name).to eql 'Seemannsgarn by Tanzwut' }
    it { expect(subject.phone).to eql '987654321' }
  end
end
