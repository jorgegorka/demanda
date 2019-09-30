require 'rails_helper'

describe Orders::PriceModifiers do
  let(:account) { create(:account) }
  let(:order) { create(:order, account: account) }
  let(:customer) { order.customer }
  let!(:tax) { create(:tax, account: account) }
  let!(:discount) { create(:discount_for_customer, account: account, customer: customer) }
  let(:order_modifiers) { described_class.new(order) }

  describe '#add' do
    before { order_modifiers.add }

    it { expect(order.order_price_modifiers.count).to eql 2 }
  end
end
