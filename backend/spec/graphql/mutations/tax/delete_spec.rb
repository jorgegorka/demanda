require 'rails_helper'

describe Mutations::Tax::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:tax) { create(:tax, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteTax (
          input: {
            id: "#{tax.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_tax' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteTax']
    end

    it { is_expected.to include 'message' => 'Tax was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
