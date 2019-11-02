require 'rails_helper'

describe Carts::Persistence do
  describe 'update' do
    let(:customer) { create(:customer) }
    let(:customer_id) { customer.uuid }
    let(:account) { customer.account }
    let(:cart) { create(:cart, account: account) }
    let(:cart_id) { cart.uuid }
    let(:product) { create(:product, account: account) }
    let(:quantity) { 3 }
    let(:params) { { product_id: product.uuid, quantity: quantity } }
    let(:cart_persistence) { described_class.new(account, cart_id, customer_id) }

    subject(:item_update) { cart_persistence.update(params) }

    context 'when cart id exists' do
      context 'when product is not in the cart' do
        it { expect { item_update }.to change{ CartItem.count }.by(1) }

        it { expect(item_update.quantity.to_i).to eql quantity }
        it { expect(item_update.price.amount).to eql product.price.amount }
      end

      context 'when product is already in the cart' do
        let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }

        it { expect { item_update }.to change{ CartItem.count }.by(0) }

        it { expect(item_update.quantity.to_i).to eql 5 }

        context 'when quantity is zero' do
          let(:quantity) { 0 }

          it { expect { item_update }.to change{ CartItem.count }.by(-1) }
        end
      end
    end

    context 'when cart id does not exist' do
      let(:cart_id) { }

      it { expect { item_update }.to change{ Cart.count }.by(1) }

      it { expect { item_update }.to change{ CartItem.count }.by(1) }

      it { expect(item_update.quantity.to_i).to eql quantity }

      context 'when customer id is present' do
        it { expect(item_update.cart.customer).to eql customer }
      end

      context 'when customer id is not present' do
        let(:customer_id) { }

        it { expect(item_update.cart.customer).to be_nil }
      end
    end
  end
end