require 'rails_helper'

describe Categories::Persistence do
  let(:account) { create(:account) }
  let(:name) { 'Toundra' }
  let(:parent_id) {}
  let(:translations) {}
  let(:params) { { name: name, parent_id: parent_id, translations: translations } }
  let(:category_persistence) { described_class.new(account) }

  describe '.create' do
    it { expect { category_persistence.create(params) }.to change{ Category.count }.by(1) }

    context 'when there is a parent category' do
      let(:parent_category) { create(:category, account: account) }
      let(:parent_id) { parent_category.uuid }

      it { expect { category_persistence.create(params) }.to change{ parent_category.children.count }.by(1) }
    end

    context 'when there are translations' do
      let(:translation1) { { language: 'FR', name: 'Alcest' } }
      let(:translation2) { { language: 'GE', name: 'Equilibrium' } }
      let(:translations) { [translation1, translation2] }

      it { expect { category_persistence.create(params) }.to change{ Translation.count }.by(2) }
    end
  end

  describe '.update' do
    let(:category) { create(:category, account: account) }
    let(:params) { { id: category.uuid, name: 'The Police' } }

    subject { category_persistence.update(params) }

    it { expect(subject.name).to eql 'The Police' }
  end
end
