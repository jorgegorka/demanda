# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Attachment::Delete, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:product) { create(:product, account: account) }
  let(:attachment) { product.attachments.create(title: 'Front page') }
  let(:jwt_token) { generate_jwt_test_token(user) }
  let(:query) do
    <<~GQL
      mutation {
        deleteAttachment (
          input: {
            id: "#{attachment.uuid}"
            parentType: products
            parentId:  "#{product.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete_attachment' do
    subject do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      parse_graphql_response(response.body)['deleteAttachment']
    end

    it { is_expected.to include 'message' => 'true' }
    it { is_expected.to include 'errors' => [] }
  end
end
