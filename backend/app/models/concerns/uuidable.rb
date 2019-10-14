require 'active_support/concern'

module Uuidable
  extend ActiveSupport::Concern

  included do
    validates :uuid, presence: true
    after_initialize :assign_uuid, if: :new_record?
  end

  private

  def assign_uuid
    self.uuid = UUIDTools::UUID.timestamp_create.to_s
  end


  class_methods do
  end
end
