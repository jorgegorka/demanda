# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Translation::Create, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) do
    <<~RESULT
      {
        name
        description
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createTranslation (
          #{input_params}
        ) {
          translation #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_translation' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createTranslation']
    end

    context 'basic input' do
      let(:language) { create(:language, account: account) }
      let(:product) { create(:product, account: account) }
      let(:name) { 'Amorphis' }
      let(:description) { 'The beginning of times' }
      let(:input_params) do
        <<~PARAMS
          input: {
            parentId: "#{product.uuid}"
            parentType: products
            languageId: "#{language.uuid}"
            name: "#{name}"
            description: "#{description}"
          }
        PARAMS
      end

      it { is_expected.to include 'translation' => { 'name' => name, 'description' => description } }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
