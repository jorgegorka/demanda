module Resolvers
  class Categories < Resolvers::Base
    type "[Types::CategoryType]", null: true

    description "Find all categories or filter by name"
    argument :name, String, required: false

    def resolve(name = nil)
      if (name.present?)
        Category.where(name: name).all
      else
        Category.all
      end
    end
  end
end