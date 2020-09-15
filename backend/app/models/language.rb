# frozen_string_literal: true

class Language < ApplicationRecord
  include Uuidable

  before_destroy :check_no_translations

  belongs_to :account

  has_many :translations, dependent: :destroy
  has_many :users, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: :account_id, case_sensitive: false }

  protected

  def check_no_translations
    if translations.any?
      errors.add(:base, 'Language should have no translations associated')
      throw :abort
    end
  end
end
