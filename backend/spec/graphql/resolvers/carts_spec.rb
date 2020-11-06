require 'rails_helper'

describe Resolvers::Carts, type: :request do
  let(:account) { create(:account, domain: 'http://www.example.com') }
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:manager) { create(:manager, account: account, password: password, email: email) }
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
            id
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
          user {
            id
          }
        }
      }
    GQL
  end

  let!(:cart) { create(:cart, account: account, user: user) }

  describe 'categories' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    context 'when user is logged in' do
      let!(:jwt_token) { generate_jwt_test_token(user) }

      subject { parse_graphql_response(response.body)['carts'].first }

      context 'a generic query returns available cart' do
        let(:query) { find_all }

        it { is_expected.to include 'user' => { 'id' => user.uuid, 'name' => 'Dio' }, 'id' => cart.uuid }
      end

      context 'a query with an id' do
        let(:query) { find_by_id }
        let(:query_string) { cart.uuid }

        it { is_expected.to include 'id' => cart.uuid }
        it { is_expected.to include 'user' => { 'id' => user.uuid } }
      end
    end

    context 'when another user is logged in' do
      let(:user2) { create(:user, account: account, name: 'Dio') }
      let!(:jwt_token) { generate_jwt_test_token(user2) }

      subject { parse_graphql_response(response.body)['carts'].first }

      context 'a generic query returns no cart' do
        let(:query) { find_all }

        it { is_expected.to be_nil }
      end

      context 'a query with an id' do
        let(:query) { find_by_id }
        let(:query_string) { cart.uuid }

        it { is_expected.to include 'id' => cart.uuid }
        it { is_expected.to include 'user' => { 'id' => user2.uuid } }
      end
    end

    context 'when user is logged out' do
      let!(:jwt_token) {}

      subject { parse_graphql_response(response.body)['carts'].first }

      context 'a query with an id' do
        let(:query) { find_by_id }
        let(:query_string) { cart.uuid }

        it { is_expected.to include 'id' => cart.uuid }
      end
    end
  end
end
