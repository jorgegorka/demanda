module Resolvers
  class Categories < Resolvers::Base
    type '[Types::CategoryType]', null: true

    description 'Find all categories or filter by name'
    argument :name, String, required: false

    def resolve(name: nil)
      if name.present?
        current_account.categories.where('NAME LIKE ?', "%#{name}%").all
      else
        current_account.categories.all
      end
    end
  end
end
