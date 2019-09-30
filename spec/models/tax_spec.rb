require 'rails_helper'

RSpec.describe Tax, type: :model do
  it_behaves_like 'price_modifiable'
end
