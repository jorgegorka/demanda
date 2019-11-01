require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }
  let(:account) { order.account }
  let(:itemA) { create(:product, account: account, price: 30) }
  let(:itemB) { create(:product, account: account, price: 20) }
  let!(:itemC) { create(:product, account: account, price: 50) }
  let!(:itemD) { create(:product, account: account, price: 15) }
  let!(:discountA) { create(:discount, account: account, amount: 15, percentage: 0, minimum_quantity: 3, product: itemA) }
  let!(:discountB) { create(:discount, account: account, amount: 5, percentage: 0, minimum_quantity: 2, product: itemB) }
  let!(:discountOrder) { create(:discount, account: account, amount: 20, percentage: 0, minimum_price: 150) }

  describe 'basket' do
    context 'when cart content is A,B,C' do
      let!(:order_itemA) { create(:order_item, order: order, quantity: 1, price: itemA.price, product: itemA) }
      let!(:order_itemB) { create(:order_item, order: order, quantity: 1, price: itemB.price, product: itemB) }
      let!(:order_itemC) { create(:order_item, order: order, quantity: 1, price: itemC.price, product: itemC) }

      before { order.add_modifiers }

      it { expect(order.net_price.to_i).to eql 100 }
    end

    context 'when cart content is B,A,B,A,A' do
      let!(:order_itemA) { create(:order_item, order: order, quantity: 3, price: itemA.price, product: itemA) }
      let!(:order_itemB) { create(:order_item, order: order, quantity: 2, price: itemB.price, product: itemB) }

      before { order.add_modifiers }

      it { expect(order.net_price.to_i).to eql 110 }
    end

    context 'when cart content is C,B,A,A,D,A,B' do
      let!(:order_itemA) { create(:order_item, order: order, quantity: 3, price: itemA.price, product: itemA) }
      let!(:order_itemB) { create(:order_item, order: order, quantity: 2, price: itemB.price, product: itemB) }
      let!(:order_itemC) { create(:order_item, order: order, quantity: 1, price: itemC.price, product: itemC) }
      let!(:order_itemD) { create(:order_item, order: order, quantity: 1, price: itemD.price, product: itemD) }

      before { order.add_modifiers }

      it { expect(order.net_price.to_i).to eql 155 }
    end

    context 'when cart content is C,A,D,A,A' do
      let!(:order_itemA) { create(:order_item, order: order, quantity: 3, price: itemA.price, product: itemA) }
      let!(:order_itemC) { create(:order_item, order: order, quantity: 1, price: itemC.price, product: itemC) }
      let!(:order_itemD) { create(:order_item, order: order, quantity: 1, price: itemD.price, product: itemD) }

      before { order.add_modifiers }

      it { expect(order.net_price.to_i).to eql 140 }
    end
  end
end