module Types
  class AttachmentType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :title, String, null: false
    field :url, String, null: false
  end
end
