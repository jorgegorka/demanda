require 'rails_helper'

describe Mutations::Customer::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) {
    <<~RESULT
      {
        name
      }
    RESULT
  }
  let(:query) do
    <<~GQL
      mutation {
        createCustomer (
          input: {
            name: "#{name}"
          }
        ) {
          customer #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_customer' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createCustomer']
    end

    context 'basic input' do
      let(:name) { 'Europa' }

      it { is_expected.to include 'customer' => { 'name' => 'Europa' } }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
