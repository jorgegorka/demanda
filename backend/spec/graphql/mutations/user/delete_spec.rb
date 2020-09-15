# frozen_string_literal: true

require 'rails_helper'

describe Mutations::User::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let!(:manager) { create(:manager, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(manager) }
  let(:query) do
    <<~GQL
      mutation {
        deleteUser (
          input: {
            id: "#{user.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'update_user' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteUser']
    end

    context 'when there are no orders associated' do
      it { is_expected.to include 'message' => 'true' }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when user has orders associated' do
      let!(:order) { create(:order, user: user) }

      it { is_expected.to include 'message' => 'false' }
      it { is_expected.to include 'errors' => ['User should have no orders associated'] }
    end
  end
end
