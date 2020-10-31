# frozen_string_literal: true

require 'rails_helper'

describe Mutations::User::Update, type: :request do
  let(:user) { create(:user) }
  let(:account) { user.account }
  let(:manager) { create(:manager, account: account) }
  let!(:jwt_token) { generate_jwt_test_token(manager) }
  let(:name) { 'Entrophy' }
  let(:phone) { '123456789' }
  let(:query) do
    <<~GQL
      mutation {
        updateUser (
          input: {
            id: "#{user.uuid}"
            name: "#{name}"
            phone: "#{phone}"
          }
        ) {
          user {
            name
            phone
          }
          errors
        }
      }
    GQL
  end

  describe 'update_user' do
    context 'managers can update any user' do
      let(:jwt_token) { generate_jwt_test_token(manager) }

      subject do
        post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
        parse_graphql_response(response.body)['updateUser']
      end

      it { is_expected.to include 'user' => { 'name' => 'Entrophy', 'phone' => '123456789' } }
      it { is_expected.to include 'errors' => [] }
    end

    context 'users can update themselves' do
      let(:jwt_token) { generate_jwt_test_token(user) }

      before do
        post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }

        user.reload
      end

      it { expect(user.name).to eql 'Entrophy' }
      it { expect(user.phone).to eql '123456789' }
    end
  end
end
