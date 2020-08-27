# frozen_string_literal: true

require 'active_support/concern'

module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable, dependent: :destroy
  end

  class_methods do
  end
end
