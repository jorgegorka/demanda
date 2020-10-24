# frozen_string_literal: true

require 'rails_helper'

describe Resolvers::Countries, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:manager) { create(:manager, password: password, email: email) }
  let!(:jwt_token) { generate_jwt_test_token(manager) }
  let(:login_email) { manager.email }
  let(:login_password) { 'unbreakable' }
  let(:user) { create(:user, account: manager.account) }
  let(:find_all) do
    <<~GQL
      query {
        countries {
          id
          name
          region
        }
      }
    GQL
  end
  let(:find_by_country_code) do
    <<~GQL
      query {
        countries(id: "ESP") {
          id
          name
          continent
          translations
        }
      }
    GQL
  end

  let!(:country1) { Country['GE'] }
  let!(:country2) { Country['FR'] }
  let!(:country3) { Country['IT'] }

  describe 'countries' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['countries'] }

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('name' => country1.name))) }
      it { is_expected.to match(array_including(a_hash_including('id' => country1.alpha3))) }
    end

    context 'return a country using id' do
      let(:query) { find_by_country_code }
      let(:query_string) { true }

      it { is_expected.to match(array_including(a_hash_including('name' => 'Spain'))) }
      it { is_expected.to match(array_including(a_hash_including('translations'))) }
    end
  end
end
