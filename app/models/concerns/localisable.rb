require 'active_support/concern'

module Localisable
  extend ActiveSupport::Concern

  included do
    has_many :translations, as: :translatable, dependent: :destroy
  end

  class_methods do
  end
end