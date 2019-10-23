require 'rails_helper'

describe Resolvers::Taxes, type: :request do
  let(:email) { 'user@test.com' }
  let(:password) { 'unbreakable' }
  let(:user) { create(:user, password: password, email: email) }
  let!(:jwt_token) { generate_jwt_test_token(user) }
  let(:login_email) { user.email }
  let(:login_password) { 'unbreakable' }
  let(:find_all) do
    <<~GQL
      query {
        taxes {
          name
        }
      }
    GQL
  end
  let(:find_by_name) do
    <<~GQL
      query {
        taxes(name: "#{query_string}") {
          id
          name
        }
      }
    GQL
  end
  let(:find_active) do
    <<~GQL
      query {
        taxes(active: true) {
          id
          name
        }
      }
    GQL
  end

  let(:active) { true }
  let(:end_at) { nil }
  let(:start_at) { 45.days.ago }
  let!(:in_flames) { create(:tax, account: user.account, name: 'In Flames', active: active, start_at: start_at, end_at: end_at) }
  let!(:in_vain) { create(:tax, account: user.account, name: 'In Vain') }
  let!(:power_quest) { create(:tax, account: user.account, name: 'Power Quest') }

  describe 'taxes' do
    before do
      post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end

    subject { parse_graphql_response(response.body)['taxes'] }

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to include 'name' => 'Power Quest' }
    end

    context 'filtered by name' do
      let(:query) { find_by_name }
      let(:query_string) { 'In' }

      it { is_expected.to include 'name' => in_flames.name, 'id' => in_flames.uuid }
      it { is_expected.to include 'name' => in_vain.name, 'id' => in_vain.uuid }
      it { is_expected.to_not include 'name' => power_quest.name, 'id' => power_quest.uuid }
    end

    context 'filtered by active' do
      let(:query) { find_active }
      let(:query_string) { 'In' }

      context 'active taxes' do
        it { is_expected.to include 'name' => in_flames.name, 'id' => in_flames.uuid }
      end

      context 'inactive taxes' do
        let(:active) { false }

        it { is_expected.to_not include 'name' => in_flames.name, 'id' => in_flames.uuid }
      end

      context 'an enabled tax' do
        it { is_expected.to include 'name' => in_flames.name, 'id' => in_flames.uuid }
      end

      context 'a disabled tax' do
        let(:end_at) { 3.days.ago }

        it { is_expected.to_not include 'name' => in_flames.name, 'id' => in_flames.uuid }
      end

      context 'a task enabled in the future' do
        let(:start_at) { 3.days.from_now }

        it { is_expected.to_not include 'name' => in_flames.name, 'id' => in_flames.uuid }
      end
    end
  end
end
