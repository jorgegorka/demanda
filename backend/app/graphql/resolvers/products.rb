# frozen_string_literal: true

module Resolvers
  class Products < Resolvers::Base
    type '[Types::ProductType]', null: true

    description 'Find all products or filter by name or category'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :name, String, required: false, default_value: ''
    argument :slug, String, required: false
    argument :category_id, String, required: false
    argument :category_slug, String, required: false
    argument :lang, String, required: false, default_value: ''

    def resolve(params)
      @db_query = current_account.products
      filter_name(params[:name])
      filter_slug(params[:slug])
      filter_uuid(params[:uuid])
      filter_category(params[:category_id], params[:category_slug])
      # filter_translation(params[:lang])

      db_query.order(:name)
    end

    protected

    def filter_category(category_id, category_slug)
      return if category_id.blank? && category_slug.blank?

      @db_query = if category_id
                    db_query.includes(:category).where(categories: { uuid: category_id })
                  else
                    db_query.includes(:category).where(categories: { slug: category_slug })
                  end
    end
  end
end
