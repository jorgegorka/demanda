# frozen_string_literal: true

class Tax < PriceModifier
  validates :account_id, presence: true
  validates :name, presence: true
end
