# frozen_string_literal: true

require 'rails_helper'

describe Mutations::User::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:manager) { create(:manager, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(manager) }
  let(:name) { 'Entrophy' }
  let(:query) do
    <<~GQL
      mutation {
        updateUser (
          input: {
            id: "#{user.uuid}"
            name: "#{name}"
          }
        ) {
          user {
            name
          }
          errors
        }
      }
    GQL
  end

  describe 'update_user' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateUser']
    end

    it { is_expected.to include 'user' => { 'name' => 'Entrophy' } }
    it { is_expected.to include 'errors' => [] }
  end
end
