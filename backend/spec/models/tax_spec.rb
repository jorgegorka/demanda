require 'rails_helper'

RSpec.describe Tax, type: :model do
  it_behaves_like 'price_modifiable'
  it_behaves_like 'localisable'

  it { is_expected.to monetize(:amount) }
  it { is_expected.to monetize(:percentage) }
  it { is_expected.to monetize(:minimum_quantity) }
  it { is_expected.to monetize(:minimum_price) }
end
