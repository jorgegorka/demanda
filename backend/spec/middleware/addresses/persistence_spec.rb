# frozen_string_literal: true

require 'rails_helper'

describe Addresses::Persistence do
  let(:account) { create(:account) }
  let(:user) { create(:user, account: account) }
  let(:params) do
    {
      name: 'home',
      first_address: 'Long address name Av.',
      second_address: 'some extra info',
      postal_code: '87123',
      city: 'Bilbao',
      country: 'ESP'
    }
  end
  let(:address_persistence) { described_class.new(user) }

  describe '.create' do
    subject { address_persistence.create(params) }

    it { expect { subject }.to change { Address.count }.by(1) }
  end

  describe '.update' do
    let(:address) { create(:address, :for_user) }
    let(:user) { address.addressable }
    let(:params) { { id: address.uuid, first_address: 'Dark Tranquility', postal_code: '99666' } }

    subject { address_persistence.update(params) }

    it { expect(subject.first_address).to eql 'Dark Tranquility' }
    it { expect(subject.postal_code).to eql '99666' }
  end

  describe '.destroy' do
    let!(:address) { create(:address, :for_user) }
    let(:user) { address.addressable }

    it { expect { address_persistence.destroy(address) }.to change { Address.count }.by(-1) }
  end
end
