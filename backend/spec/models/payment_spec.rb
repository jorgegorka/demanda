# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :order }

  it { is_expected.to monetize(:total) }

  it { should define_enum_for(:origin).with(%i[bank_transfer credit_card cash]) }
end
