# frozen_string_literal: true

require 'rails_helper'

describe Resolvers::Addresses, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:user) { create(:user, password: password, email: email) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:login_email) { user.email }
  let(:login_password) { 'unbreakable' }
  let(:find_all) do
    <<~GQL
      query {
        addresses {
          name
          firstAddress
          city
        }
      }
    GQL
  end
  let(:find_by_id) do
    <<~GQL
      query {
        addresses(id: "#{query_string}") {
          id
          name
          firstAddress
          city
        }
      }
    GQL
  end

  let!(:in_flames) { create(:address, :for_user, addressable: user, city: 'In Flames') }
  let!(:in_vain) { create(:address, :for_user, addressable: user, city: 'In Vain') }
  let!(:power_quest) { create(:address, :for_user, addressable: user, city: 'Power Quest') }

  describe 'addresses' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['addresses'] }

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('city' => power_quest.city))) }
    end

    context 'a query with id' do
      let(:query) { find_by_id }
      let(:query_string) { in_vain.uuid }

      it { is_expected.to match(array_including(a_hash_including('id' => in_vain.uuid))) }
      it { is_expected.to_not match(array_including(a_hash_including('id' => in_flames.uuid))) }
      it { is_expected.to_not match(array_including(a_hash_including('id' => power_quest.uuid))) }
    end
  end
end
