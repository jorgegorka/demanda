require 'rails_helper'

describe Mutations::Cart::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Spiritual Instinct' }
  let(:query) do
    <<~GQL
      mutation {
        updateCart (
          input: {
            quantity: 10
            productId: "#{product.uuid}"
          }
        ) {
          cart {
            cartItems {
              product {
                name
              }
              quantity
            }
            totalGross
            totalNet
            totalTax
            totalDiscount
          }
          errors
        }
      }
    GQL
  end

  describe 'update_cart' do
    subject(:update_cart) do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateCart']
    end

    it { expect(update_cart['cart']).to include 'cartItems' => [{ 'product' => { 'name' => product.name }, 'quantity' => 10.0 }] }
    it { is_expected.to include 'errors' => [] }
  end
end
