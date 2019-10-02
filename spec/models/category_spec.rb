require 'rails_helper'

RSpec.describe Category, type: :model do
  it_behaves_like 'uuidable'
  it_behaves_like 'localisable'

  it { is_expected.to belong_to :account }

  it { is_expected.to have_many :products }

  it { is_expected.to validate_presence_of :name }
end
