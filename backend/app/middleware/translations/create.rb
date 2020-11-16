# frozen_string_literal: true

module Translations
  CONTENT_FOR_PRODUCT = %i[meta-title meta-description summary description].freeze

  class Create
    class << self
      def content_for_product(product)
        language = Language.find_by(code: I18n.default_locale.to_s)
        return unless language

        CONTENT_FOR_PRODUCT.each do |content|
          product.translations.create(
            name: content,
            language: language
          )
        end
      end
    end
  end
end
