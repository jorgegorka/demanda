# frozen_string_literal: true

module Categories
  class Persistence
    attr_reader :account

    def initialize(account)
      @account = account
    end

    def create(params)
      parent_id = params.delete(:parent_id)
      translations = params.delete(:translations)
      category = parent_id.present? ? add_to_parent(params, parent_id) : account.categories.create(params)
      category.translations.create(translations) if translations.present?

      category
    end

    def update(params)
      category = account.categories.find_by(uuid: params.delete(:id))
      category.update(params)

      category
    end

    protected

    def add_to_parent(params, parent_id)
      parent = account.categories.find_by(uuid: parent_id)

      parent.children.create(params)
    end
  end
end
