require 'rails_helper'

describe Languages::Persistence do
  let(:account) { create(:account) }
  let(:name) { 'Soilwork' }
  let(:params) { { name: name } }
  let(:language_persistence) { described_class.new(account) }

  describe '.create' do
    it { expect { language_persistence.create(params) }.to change{ Language.count }.by(1) }
  end

  describe '.update' do
    let(:language) { create(:language, account: account) }
    let(:params) { { id: language.uuid, name: 'The Police' } }

    subject { language_persistence.update(params) }

    it { expect(subject.name).to eql 'The Police' }
  end
end
