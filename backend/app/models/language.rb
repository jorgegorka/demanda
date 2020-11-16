# frozen_string_literal: true

class Language < ApplicationRecord
  include Uuidable

  before_destroy :check_no_translations
  before_validation :add_default_code

  belongs_to :account

  has_many :translations, dependent: :destroy
  has_many :users, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: :account_id, case_sensitive: false }
  validates :code, presence: true, uniqueness: { scope: :account_id, case_sensitive: false }

  private

  def check_no_translations
    if translations.any?
      errors.add(:base, 'Language should have no translations associated')
      throw :abort
    end
  end

  def add_default_code
    return if code.present? || name.blank?

    self.code = name[0...2]
  end
end
