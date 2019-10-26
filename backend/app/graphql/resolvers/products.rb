# frozen_string_literal: true

module Resolvers
  class Products < Resolvers::Base
    type '[Types::ProductType]', null: true

    description 'Find all products or filter by name or category'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :name, String, required: false, default_value: ''
    argument :category_id, String, required: false, default_value: ''
    argument :lang, String, required: false, default_value: ''

    def resolve(uuid:, name:, lang:, category_id:)
      @db_query = current_account.products
      filter_name(name)
      filter_uuid(uuid)
      filter_category(category_id)
      # filter_translation(lang)

      db_query.order(:name)
    end

    protected

    def filter_category(category_id)
      return if category_id.blank?

      @db_query = db_query.where(category_id: category_id)
    end
  end
end
