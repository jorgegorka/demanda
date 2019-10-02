class Category < ApplicationRecord
  include Uuidable
  include Localisable

  acts_as_tree order: 'name'

  belongs_to :account

  has_many :products

  validates :name, presence: true, uniqueness: { scope: %i[account_id parent_id] }

  after_initialize :set_parent_account, if: :new_record?

  protected

  def set_parent_account
    self.account_id = parent.account_id if parent.present?
  end
end
