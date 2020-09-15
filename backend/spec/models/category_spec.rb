# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'localisable'
  it_behaves_like 'attachable'
  it_behaves_like 'slugable'

  it { is_expected.to belong_to :account }

  it { is_expected.to have_many :products }

  it { is_expected.to validate_presence_of :name }
end
