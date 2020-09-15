# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'slugable' do
  describe '#slug' do
    let(:slugable_instance) { create(described_class.name.underscore.to_sym, slug: slug) }
    subject { slugable_instance.slug }

    context 'when slug is empty' do
      let(:slug) {}

      it { is_expected.to eql slugable_instance.name.parameterize }
    end

    context 'when slug is provided' do
      let(:slug) { 'custom-slug' }

      it { is_expected.to eql slug }
    end
  end
end
