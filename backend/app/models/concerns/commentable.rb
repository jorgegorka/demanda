# frozen_string_literal: true

require 'active_support/concern'

module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, -> { where(approved: true) }, as: :commentable, dependent: :destroy
  end

  class_methods do
  end
end
