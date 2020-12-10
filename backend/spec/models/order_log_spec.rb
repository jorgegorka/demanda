# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderLog, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :order }

  it { is_expected.to validate_presence_of(:description) }
end
