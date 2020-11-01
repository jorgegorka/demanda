require 'rails_helper'

describe Carts::Persistence do
  describe 'update' do
    let(:user) { create(:user) }
    let(:account) { user.account }
    let(:user_id) { user_id.uuid }
    let(:cart) { create(:cart, account: account) }
    let(:cart_id) { cart.uuid }
    let(:product) { create(:product, account: account) }
    let(:quantity) { 3 }
    let(:params) { { product_id: product.uuid, quantity: quantity } }
    let(:cart_persistence) { described_class.new({ account: account, cart_id: cart_id, user: user }) }

    subject(:item_update) do
      cart_persistence.update(params)
      CartItem.find_by(product: product)
    end

    context 'when cart id exists' do
      context 'when product is not in the cart' do
        it { expect { item_update }.to change { CartItem.count }.by(1) }

        it { expect(item_update.quantity.to_i).to eql quantity }
        it { expect(item_update.price.amount).to eql product.price.amount }
      end

      context 'when product is already in the cart' do
        let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }

        it { expect { item_update }.to change { CartItem.count }.by(0) }

        it { expect(item_update.quantity.to_i).to eql 5 }

        context 'when quantity is zero' do
          let(:quantity) { 0 }

          it { expect { item_update }.to change { CartItem.count }.by(-1) }
        end

        context 'when quantity is negative but total quantity is greater than zero' do
          let(:quantity) { -1 }

          it { expect { item_update }.to change { CartItem.count }.by(0) }

          it { expect(item_update.quantity.to_i).to eql 1 }
        end

        context 'when quantity is negative and total quantity is below zero' do
          let(:quantity) { -9 }

          it { expect { item_update }.to change { CartItem.count }.by(-1) }
        end
      end
    end

    context 'when cart id does not exist' do
      let(:cart_id) {}

      it { expect { item_update }.to change { Cart.count }.by(1) }

      it { expect { item_update }.to change { CartItem.count }.by(1) }

      it { expect(item_update.quantity.to_i).to eql quantity }

      context 'when user id is present' do
        it { expect(item_update.cart.user).to eql user }
      end

      context 'when user id is not present' do
        let(:user) {}
        let(:account) { create(:account) }

        it { expect(item_update.cart.user).to be_nil }
      end
    end
  end
end
