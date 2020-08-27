# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Comment::Create, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:language) { create(:language, account: account) }
  let(:product) { create(:product, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:result_info) do
    <<~RESULT
      {
        description
        user {
          id
        }
        language {
          name
        }
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createComment (
          #{input_params}
        ) {
          comment #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create_comment' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['createComment']
    end

    context 'basic input' do
      let(:description) { 'An amazing comment that I give to you' }
      let(:input_params) do
        <<~PARAMS
          input: {
            description: "#{description}"
            parentId: "#{product.uuid}"
            parentType: "products"
            languageId: "#{language.id}"
          }
        PARAMS
      end

      it { is_expected.to include 'comment' => { 'description' => description, 'language' => { 'name' => language.name }, 'user' => { 'id' => user.uuid } } }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
