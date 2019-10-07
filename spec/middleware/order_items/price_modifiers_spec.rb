require 'rails_helper'

describe OrderItems::PriceModifiers do
  let(:account) { create(:account) }
  let(:customer) { create(:customer, account: account) }
  let(:order) { create(:order, account: account, customer: customer) }
  let(:category) { create(:category, account: account) }
  let(:product) { create(:product, account: account, category: category) }
  let(:order_item) { build(:order_item, order: order, product: product) }
  let!(:tax) { create(:tax, account: account, category: category) }
  let!(:discount) { create(:discount_for_customer, account: account, product: product, customer: customer) }
  let(:order_item_modifiers) { described_class.new(order_item) }

  describe '#add' do
    before { order_item.save }

    it { expect(order_item.order_price_modifiers.count).to eql 2 }
  end
end
