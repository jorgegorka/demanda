# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Language::Delete, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:language) { create(:language, account: account) }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteLanguage (
          input: {
            id: "#{language.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_language' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteLanguage']
    end

    context 'when there are no translations associated' do
      it { is_expected.to include 'message' => 'true' }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when language has translations associated' do
      let!(:translation) do
        category = create(:category, account: account)
        category.translations.create(name: 'Oathbreaker', language: language)
      end

      it { is_expected.to include 'message' => 'false' }
      it { is_expected.to include 'errors' => ['Language should have no translations associated'] }
    end
  end
end
