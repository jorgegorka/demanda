require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to belong_to :addressable }

  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:address_1) }
end
