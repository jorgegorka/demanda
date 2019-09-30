require 'rails_helper'

RSpec.describe Discount, type: :model do
  it_behaves_like 'price_modifiable'
end
