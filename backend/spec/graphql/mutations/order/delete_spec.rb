require 'rails_helper'

describe Mutations::Order::Delete, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:order) { create(:order, account: account) }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteOrder (
          input: {
            id: "#{order.uuid}"
          }
        ) {
          errors
        }
      }
    GQL
  end

  describe 'update_order' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteOrder']
    end

    it { is_expected.to include 'errors' => [] }
  end
end
