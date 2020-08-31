# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Comment::Update, type: :request do
  let(:user) { create(:manager) }
  let(:account) { user.account }
  let(:comment) { create(:comment, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:reply) { 'Darkthrone has an album called The underground resistance.' }
  let(:approved) { true }
  let(:query) do
    <<~GQL
      mutation {
        updateComment (
          input: {
            id: "#{comment.uuid}"
            approved: #{approved}
            replyDescription: "#{reply}"
          }
        ) {
          comment {
            approved
            replyDescription
            repliedAt
          }
          errors
        }
      }
    GQL
  end

  describe 'update_comment' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['updateComment']['comment']
    end

    it { is_expected.to include 'approved' => true }
    it { is_expected.to include 'repliedAt' => comment.reload.replied_at }
    it { is_expected.to include 'replyDescription' => 'Darkthrone has an album called The underground resistance.' }
  end
end
