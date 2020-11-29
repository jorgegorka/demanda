# frozen_string_literal: true

require 'rails_helper'

describe Orders::Persistence do
  let(:user) { create(:user) }
  let(:order_persistence) { described_class.new(user) }
  let(:params) do
    {
      total_tax: 10,
      total_discount: 4
    }
  end

  describe '#create' do
    it { expect { order_persistence.create(params) }.to change { Order.count }.by(1) }

    context 'order info' do
      subject { order_persistence.create(params) }

      it { expect(subject.total_tax.amount).to eql 10.0 }
      it { expect(subject.total_discount.amount).to eql 4.0 }
    end
  end
end
