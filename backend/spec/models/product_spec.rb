# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'localisable'
  it_behaves_like 'attachable'
  it_behaves_like 'commentable'

  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to :category }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to monetize(:price) }

  describe '#tags_for_query' do
    let(:product) { create(:product) }

    subject { product.tags_for_query }

    it { is_expected.to eql product.tag_names.join(', ') }
  end
end
