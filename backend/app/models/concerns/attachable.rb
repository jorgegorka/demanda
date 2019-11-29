require 'active_support/concern'

module Attachable
  extend ActiveSupport::Concern

  included do
    has_many :attachments, as: :attachable, dependent: :destroy
  end

  class_methods do
  end
end
