require 'rails_helper'

describe Resolvers::Carts, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:manager) { create(:manager, password: password, email: email) }
  let(:account) { manager.account }
  let!(:jwt_token) { generate_jwt_test_token(manager) }
  let(:login_email) { manager.email }
  let(:login_password) { 'unbreakable' }
  let(:user) { create(:user, account: account, name: 'Dio') }
  let(:find_all) do
    <<~GQL
      query {
        carts {
          id
          user {
            name
          }
          cartItems {
            product {
              name
              price
            }
            quantity
            totalGross
            totalNet
            totalTax
            totalDiscount
            total
          }
        }
      }
    GQL
  end
  let(:find_by_id) do
    <<~GQL
      query {
        carts(id: "#{query_string}") {
          id
        }
      }
    GQL
  end

  let!(:cart) { create(:cart, account: account, user: user) }

  describe 'categories' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['carts'].first }

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to include 'user' => { 'name' => 'Dio' }, 'id' => cart.uuid }
    end

    context 'a query with an id' do
      let(:query) { find_by_id }
      let(:query_string) { cart.uuid }

      it { is_expected.to include 'id' => cart.uuid }
    end
  end
end
