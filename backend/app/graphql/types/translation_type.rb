module Types
  class TranslationType < Types::BaseObject
    field :name, String, null: false
    field :language, String, null: false
    field :description, String, null: true
  end
end
