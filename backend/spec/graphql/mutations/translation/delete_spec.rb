require 'rails_helper'

describe Mutations::Translation::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:language) { create(:language, account: account) }
  let(:product) { create(:product, account: account) }
  let(:translation) { product.translations.create(name: 'Skyforger', language: language) }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteTranslation (
          input: {
            id: "#{translation.uuid}"
            parentType: "products"
            parentId:  "#{product.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete_translation' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteTranslation']
    end

    it { is_expected.to include 'message' => 'true' }
    it { is_expected.to include 'errors' => [] }
  end
end
