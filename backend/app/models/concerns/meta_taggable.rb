# frozen_string_literal: true

require 'active_support/concern'

module MetaTaggable
  extend ActiveSupport::Concern

  included do
  end

  def meta_title
    translations.with_meta_title&.first&.description
  end

  def meta_description
    translations.with_meta_description&.first&.description
  end

  class_methods do
  end
end
