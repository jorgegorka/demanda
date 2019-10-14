require 'rails_helper'

describe Mutations::Customer::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:customer) { create(:customer, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteCustomer (
          input: {
            id: "#{customer.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_customer' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteCustomer']
    end

    context 'when there are no orders associated' do
      it { is_expected.to include 'message' => 'true' }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when customer has orders associated' do
      let!(:order) { create(:order, customer: customer) }

      it { is_expected.to include 'message' => 'false' }
      it { is_expected.to include 'errors' => ['Customer should have no orders associated'] }
    end
  end
end
