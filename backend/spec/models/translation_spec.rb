require 'rails_helper'

RSpec.describe Translation, type: :model do
  it { is_expected.to belong_to :language }

  it { is_expected.to validate_presence_of :name  }
end
