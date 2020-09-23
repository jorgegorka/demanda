# frozen_string_literal: true

class Product < ApplicationRecord
  include Uuidable
  include Localisable
  include Attachable
  include Commentable
  include Slugable

  Gutentag::ActiveRecord.call self

  belongs_to :account
  belongs_to :category, optional: true

  validates :name, presence: true

  monetize :price_cents

  delegate :uuid, to: :category, prefix: true, allow_nil: true

  def tags_for_query
    tag_names.join(', ')
  end
end
