module Categories
  class Persistence
    attr_reader :account

    def initialize(account)
      @account = account
    end

    def create(name:, parent_id:, translations:)
      category = parent_id.present? ? add_to_parent(name, parent_id) : account.categories.create(name: name)
      category.translations.create(translations) if translations.present?

      category
    end

    def update(params)
      category = account.categories.find_by(uuid: params.delete(:id))
      category.update(params)

      category
    end

    protected

    def add_to_parent(name, parent_id)
      parent = account.categories.find_by_uuid(parent_id)

      parent.children.create(name: name)
    end
  end
end
