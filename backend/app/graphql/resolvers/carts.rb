# frozen_string_literal: true

module Resolvers
  class Carts < Resolvers::Base
    type [Types::CartType], null: true

    description 'Find all carts or filter by id'
    argument :id, String, required: false, default_value: '', as: :uuid

    def resolve(uuid:)
      @cart_uuid = uuid
      return [] if no_user_no_id

      @db_query = carts
      find_cart_by_uuid

      db_query
    end

    private

    attr_reader :cart_uuid

    def no_user_no_id
      current_user.blank? && cart_uuid.blank?
    end

    def find_cart_by_uuid
      return if cart_uuid.blank?

      assign_cart_to_user

      filter_uuid(cart_uuid)
    end

    def carts
      cart_uuid.present? ? current_account.carts : current_account.carts.where(user: current_user)
    end

    def assign_cart_to_user
      cart = current_account.carts.find_by(uuid: cart_uuid)
      cart.update(user: current_user) if current_user.present?
    end
  end
end
