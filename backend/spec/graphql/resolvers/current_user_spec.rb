require 'rails_helper'

describe Resolvers::CurrentUser, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:user) { create(:user, password: password, email: email) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:login_email) { user.email }
  let(:login_password) { 'unbreakable' }
  let(:query) do
    <<~GQL
      query {
        currentUser {
          email
          name
          cart {
            id
          }
        }
      }
    GQL
  end

  describe 'categories' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject(:current_user) { parse_graphql_response(response.body)['currentUser'] }

    it { is_expected.to include 'email' => user.email }
    it { is_expected.to include 'name' => user.name }
  end
end
