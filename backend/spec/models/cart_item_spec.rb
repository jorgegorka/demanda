require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it { is_expected.to belong_to :cart }
end
