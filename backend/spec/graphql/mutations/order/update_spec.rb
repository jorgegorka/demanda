# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Order::Update, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:order) { create(:order, user: user) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:status) { 'Rejected' }
  let(:query) do
    <<~GQL
      mutation {
        updateOrder (
          input: {
            id: "#{order.uuid}"
            status: #{status}
          }
        ) {
          order {
            id
            status
          }
          errors
        }
      }
    GQL
  end

  describe 'update_order' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateOrder']
    end

    it { is_expected.to include 'order' => { 'status' => 'Rejected', 'id' => order.uuid } }
    it { is_expected.to include 'errors' => [] }
  end
end
