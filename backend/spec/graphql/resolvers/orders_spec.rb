# frozen_string_literal: true

require 'rails_helper'

describe Resolvers::Orders, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:user) { create(:user, password: password, email: email) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:login_email) { user.email }
  let(:login_password) { 'unbreakable' }
  let(:find_all) do
    <<~GQL
      query {
        orders {
          status
          orderItems {
            quantity
            total
          }
        }
      }
    GQL
  end
  let(:find_by_status) do
    <<~GQL
      query {
        orders(status: "#{query_string}") {
          id
          status
        }
      }
    GQL
  end

  let!(:order1) { create(:order, user: user, status: :received) }
  let!(:order2) { create(:order, user: user, status: :approved) }
  let!(:order3) { create(:order, user: user, status: :delivered) }

  describe 'orders' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['orders'] }

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to include 'status' => 'Received', 'orderItems' => [] }
    end

    context 'a query with name' do
      let(:query) { find_by_status }
      let(:query_string) { 'delivered' }

      it { is_expected.to_not include 'status' => 'Approved', 'id' => order1.uuid }
      it { is_expected.to_not include 'status' => 'Received', 'id' => order2.uuid }
      it { is_expected.to include 'status' => 'Delivered', 'id' => order3.uuid }
    end
  end
end
