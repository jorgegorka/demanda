# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'meta_taggable' do
  describe '#meta title' do
    let(:parent) { create(described_class.name.underscore.to_sym) }
    let!(:meta_title) { create(:translation, translatable: parent, name: 'meta-title', description: 'The awesome title') }

    subject { parent }

    it { expect(subject.meta_title).to eql 'The awesome title' }
  end

  describe '#meta description' do
    let(:parent) { create(described_class.name.underscore.to_sym) }
    let!(:meta_description) { create(:translation, translatable: parent, name: 'meta-description', description: 'The remarkable description') }

    subject { parent }

    it { expect(subject.meta_description).to eql 'The remarkable description' }
  end
end
