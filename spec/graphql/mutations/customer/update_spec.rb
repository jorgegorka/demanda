require 'rails_helper'

describe Mutations::Customer::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:customer) { create(:customer, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Entrophy' }
  let(:query) do
    <<~GQL
      mutation {
        updateCustomer (
          input: {
            uuid: "#{customer.uuid}"
            name: "#{name}"
          }
        ) {
          customer {
            name
          }
          errors
        }
      }
    GQL
  end

  describe 'update_customer' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateCustomer']
    end

    it { is_expected.to include 'customer' => {'name' => 'Entrophy'} }
    it { is_expected.to include 'errors' => [] }
  end
end
