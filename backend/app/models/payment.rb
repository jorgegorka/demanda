# frozen_string_literal: true

class Payment < ApplicationRecord
  include Uuidable

  belongs_to :order

  monetize :total_cents

  enum origin: { bank_transfer: 0, credit_card: 1, cash: 2 }
end
