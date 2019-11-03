require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { create(:cart) }
  let(:account) { cart.account }
  let(:item_a) { create(:product, account: account, price: 30) }
  let(:item_b) { create(:product, account: account, price: 20) }
  let!(:item_c) { create(:product, account: account, price: 50) }
  let!(:item_d) { create(:product, account: account, price: 15) }
  let!(:discount_item_a) { create(:discount, account: account, amount: 15, percentage: 0, minimum_quantity: 3, product: item_a) }
  let!(:discount_item_b) { create(:discount, account: account, amount: 5, percentage: 0, minimum_quantity: 2, product: item_b) }
  let!(:discount_global) { create(:discount, account: account, amount: 20, percentage: 0, minimum_price: 150) }
  let(:checkout) { Carts::Persistence.new({ account: account, cart_id: cart.uuid }) }

  describe 'basket' do
    context 'when cart content is A,B,C' do
      before do
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_b.uuid, quantity: 1 })
        checkout.update({ product_id: item_c.uuid, quantity: 1 })
      end

      it { expect(cart.reload.total.to_i).to eql 100 }
    end

    context 'when cart content is B,A,B,A,A' do
      before do
        checkout.update({ product_id: item_b.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_b.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
      end

      it { expect(cart.reload.total.to_i).to eql 110 }
    end

    context 'when cart content is C,B,A,A,D,A,B' do
      before do
        checkout.update({ product_id: item_c.uuid, quantity: 1 })
        checkout.update({ product_id: item_b.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_d.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_b.uuid, quantity: 1 })
      end

      it { expect(cart.reload.total.to_i).to eql 155 }
    end

    context 'when cart content is C,A,D,A,A' do
      before do
        checkout.update({ product_id: item_c.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_d.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
        checkout.update({ product_id: item_a.uuid, quantity: 1 })
      end

      it { expect(cart.reload.total.to_i).to eql 140 }
    end
  end
end
