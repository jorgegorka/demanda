# frozen_string_literal: true

class Category < ApplicationRecord
  include Uuidable
  include Localisable
  include Attachable
  include Slugable
  include MetaTaggable

  before_destroy :check_empty_products

  acts_as_tree order: 'name', counter_cache: true

  belongs_to :account

  has_many :products

  validates :name, presence: true, uniqueness: { scope: %i[account_id parent_id], case_sensitive: false }
  validates :slug, uniqueness: { scope: :account_id,  case_sensitive: false }

  after_initialize :set_parent_account, if: :new_record?

  protected

  def check_empty_products
    if products.any? || children.any?
      errors.add(:base, 'Category should have no products or subcategories associated')
      throw :abort
    end
  end

  def set_parent_account
    self.account_id = parent.account_id if parent.present?
  end
end
