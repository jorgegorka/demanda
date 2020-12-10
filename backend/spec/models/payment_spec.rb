# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :order }

  it { is_expected.to monetize(:total) }

  it { should define_enum_for(:origin).with(%i[bank_transfer credit_card cash]) }

  describe 'after create' do
    let(:order) { create(:order) }

    subject { order.payments.create(origin: :cash, total: 0) }

    it 'should update order payment status' do
      expect_any_instance_of(Orders::Status).to receive(:payment_updated)

      subject
    end

    it { expect { subject }.to change { OrderLog.count }.by(2) }
  end
end
