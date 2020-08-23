# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :account }

  it { is_expected.to have_many :translations }
  it { is_expected.to have_many :customers }

  it { is_expected.to validate_presence_of :name }
end
