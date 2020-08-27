# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Language::Update, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:language) { create(:language, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:name) { 'Ciconia' }
  let(:query) do
    <<~GQL
      mutation {
        updateLanguage (
          input: {
            id: "#{language.uuid}"
            name: "#{name}"
          }
        ) {
          language {
            name
          }
          errors
        }
      }
    GQL
  end

  describe 'update_language' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateLanguage']
    end

    it { is_expected.to include 'language' => { 'name' => 'Ciconia' } }
    it { is_expected.to include 'errors' => [] }
  end
end
