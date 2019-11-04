require 'rails_helper'

describe Resolvers::Carts, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:user) { create(:user, password: password, email: email) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:login_email) { user.email }
  let(:login_password) { 'unbreakable' }
  let(:customer) { create(:customer, account: account, name: 'Dio') }
  let(:find_all) do
    <<~GQL
      query {
        carts {
          id
          customer {
            name
          }
          cartItems {
            product {
              name
              price
            }
            quantity
            grossTotal
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

  let!(:cart) { create(:cart, account: account, customer: customer) }

  describe 'categories' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['carts'].first }

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to include 'customer' => { 'name' => 'Dio' }, 'id' => cart.uuid }
    end

    context 'a query with an id' do
      let(:query) { find_by_id }
      let(:query_string) { cart.uuid }

      it { is_expected.to include 'id' => cart.uuid }
    end
  end
end
