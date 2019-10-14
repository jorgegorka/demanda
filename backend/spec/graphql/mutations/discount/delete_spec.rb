require 'rails_helper'

describe Mutations::Discount::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:discount) { create(:discount, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteDiscount (
          input: {
            id: "#{discount.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_discount' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteDiscount']
    end

    it { is_expected.to include 'message' => 'Discount was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
