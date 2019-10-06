# frozen_string_literal: true

class Discount < PriceModifier
  def tax?
    false
  end
end
