require 'rails_helper'

describe Mutations::Translation::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:language) { create(:language, account: account) }
  let(:product) { create(:product, account: account) }
  let(:translation) { product.translations.create(name: 'Skyforger', language: language) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Amorphis' }
  let(:description) { 'Under the red cloud' }
  let(:query) do
    <<~GQL
      mutation {
        updateTranslation (
          input: {
            id: "#{translation.uuid}"
            parentId: "#{product.uuid}"
            parentType: products
            name: "#{name}"
            description: "#{description}"
          }
        ) {
          translation {
            name
            description
          }
          errors
        }
      }
    GQL
  end

  describe 'update_translation' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateTranslation']
    end

    it { is_expected.to include 'translation' => {'name' => name, 'description' => description } }
    it { is_expected.to include 'errors' => [] }
  end
end
