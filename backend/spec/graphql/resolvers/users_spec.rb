require 'rails_helper'

describe Resolvers::Users, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:user) { create(:user, password: password, email: email) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:login_email) { user.email }
  let(:login_password) { 'unbreakable' }
  let(:find_by_name) do
    <<~GQL
      query {
        users(name: "#{query_string}") {
          id
          name
        }
      }
    GQL
  end
  let(:find_by_email) do
    <<~GQL
      query {
        users(email: "#{query_string}") {
          id
          name
          email
        }
      }
    GQL
  end

  let!(:in_flames) { create(:user, account: user.account, name: 'In Flames') }
  let!(:in_vain) { create(:user, account: user.account, name: 'In Vain') }
  let!(:power_quest) { create(:user, account: user.account, name: 'Power Quest') }

  describe 'users' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['users'] }

    context 'filtered by name' do
      let(:query) { find_by_name }
      let(:query_string) { 'In' }

      it { is_expected.to include 'name' => in_flames.name, 'id' => in_flames.uuid }
      it { is_expected.to include 'name' => in_vain.name, 'id' => in_vain.uuid }
      it { is_expected.to_not include 'name' => power_quest.name, 'id' => power_quest.uuid }
    end

    context 'filtered by email' do
      let(:query) { find_by_email }
      let(:query_string) { power_quest.email }

      it { is_expected.to include 'name' => power_quest.name, 'id' => power_quest.uuid, "email" => power_quest.email }
      it { is_expected.to_not include 'name' => in_flames.name, 'id' => in_flames.uuid, "email" => in_flames.email }
    end
  end
end
