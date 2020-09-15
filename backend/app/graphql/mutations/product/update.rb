# frozen_string_literal: true

module Mutations
  module Product
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateProduct'

      argument :id, String, required: true
      argument :name, String, required: true
      argument :slug, String, required: false
      argument :category_id, String, required: false
      argument :description, String, required: false
      argument :summary, String, required: false
      argument :meta_description, String, required: false
      argument :meta_title, String, required: false
      argument :tags, String, required: false
      argument :price, Float, required: false
      argument :stock, Integer, required: false

      field :errors, [String], null: true
      field :product, Types::ProductType, null: true

      def resolve(params)
        authorise_user

        product = Products::Persistence.new(current_account).update(params)
        {
          errors: product.errors.full_messages,
          product: product
        }
      end
    end
  end
end
