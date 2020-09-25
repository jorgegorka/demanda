# frozen_string_literal: true

require 'active_support/concern'

module Slugable
  extend ActiveSupport::Concern

  included do
    before_save :parameterize_name
  end

  private

  def parameterize_name
    return if slug.present? || name.blank?

    self.slug = name.parameterize
  end

  class_methods do
  end
end
