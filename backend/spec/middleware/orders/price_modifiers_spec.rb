require 'rails_helper'

describe Orders::PriceModifiers do
  let(:account) { create(:account) }
  let(:order) { create(:order, account: account) }
  let(:customer) { order.customer }
  let!(:tax) { create(:tax, account: account) }
  let!(:discount) { create(:discount_for_customer, account: account, customer: customer) }
  let!(:coupon) { create(:coupon, account: account) }
  let(:order_modifiers) { described_class.new(order) }

  describe '#add' do
    subject { order_modifiers.add }

    it { is_expected.to include tax }
    it { is_expected.to include discount }
  end
end
