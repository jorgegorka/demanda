# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Comment::Delete, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let!(:comment) { create(:comment, user: user) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteComment (
          input: {
            id: "#{comment.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete comment' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteComment']
    end

    context 'when comment belongs to current account' do
      it { is_expected.to include 'message' => 'Comment was deleted' }
      it { is_expected.to include 'errors' => [] }
    end

    context 'when comment belongs to another account' do
      let(:comment) { create(:comment) }

      it { is_expected.to include 'message' => '' }
      it { is_expected.to include 'errors' => ["id: #{comment.uuid}", 'Comment not found'] }
    end
  end
end
