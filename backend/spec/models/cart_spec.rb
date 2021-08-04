require 'rails_helper'

RSpec.describe Cart, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :account }
  it { is_expected.to belong_to(:user).optional }
end
