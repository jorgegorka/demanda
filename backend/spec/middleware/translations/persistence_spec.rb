require 'rails_helper'

describe Translations::Persistence do
  let(:account) { create(:account) }
  let(:language) { create(:language, account: account) }
  let(:parent) { create(:category, account: account) }
  let(:name) { 'Soilwork' }
  let(:params) { { language_id: language.uuid, name: name, parent_id: parent.uuid, parent_type: 'categories' } }
  let(:translation_persistence) { described_class.new(account) }

  describe '.create' do
    it { expect { translation_persistence.create(params) }.to change{ Translation.count }.by(1) }
  end

  describe '.update' do
    let(:translation) { parent.translations.create(name: name, language_id: language.id) }
    let(:params) { { id: translation.uuid, name: 'The Police', parent_id: parent.uuid, parent_type: 'categories'  } }

    subject { translation_persistence.update(params) }

    it { expect(subject.name).to eql 'The Police' }
  end

  describe '.destroy' do
    let!(:translation) { parent.translations.create(name: name, language_id: language.id) }
    let(:params) { { id: translation.uuid, parent_id: parent.uuid, parent_type: 'categories'  } }

    it { expect { translation_persistence.destroy(params) }.to change{ Translation.count }.by(-1) }
  end
end
