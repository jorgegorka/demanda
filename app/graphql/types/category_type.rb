module Types
  class CategoryType < Types::BaseObject
    field :uuid, String, null: false
    field :name, String, null: false
    field :parent, Types::CategoryType, null: true
    field :children, [Types::CategoryType], null: true
  end
end
