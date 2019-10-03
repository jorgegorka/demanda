require 'rails_helper'

describe Mutations::Tax::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:tax) { create(:tax, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Lullaby' }
  let(:query) do
    <<~GQL
      mutation {
        updateTax (
          input: {
            uuid: "#{tax.uuid}"
            name: "#{name}"
          }
        ) {
          tax {
            name
          }
          errors
        }
      }
    GQL
  end

  describe 'update_tax' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateTax']
    end

    it { is_expected.to include 'tax' => {'name' => 'Lullaby'} }
    it { is_expected.to include 'errors' => [] }
  end
end
