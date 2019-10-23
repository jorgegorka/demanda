# frozen_string_literal: true

module Resolvers
  class Products < Resolvers::Base
    type '[Types::ProductType]', null: true

    description 'Find all products or filter by name or category'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :name, String, required: false, default_value: ''
    argument :categoryId, String, required: false, default_value: ''
    argument :lang, String, required: false, default_value: ''

    def resolve(uuid:, name:, lang:, categoryId:)
      @db_query = current_account.categories
      filter_name(name)
      filter_uuid(uuid)
      filter_category(categoryId)
      # filter_translation(lang)

      db_query.order(:name)
    end

    protected

    def filter_category(categoryId)
      return if categoryId.blank?

      @db_query = db_query.where(category_id: categoryId)
    end
  end
end
