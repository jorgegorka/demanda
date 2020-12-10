# frozen_string_literal: true

class OrderLog < ApplicationRecord
  include Uuidable

  belongs_to :order

  validates :description, presence: true
end
