# frozen_string_literal: true

module Attachments
  class Persistence
    include Shared::ParentManager

    attr_reader :account, :parent

    def initialize(account)
      @account = account
    end

    def create(params)
      find_parent(params)
      parse_file(params)
      attachment = parent.attachments.create(params)

      attachment
    end

    def destroy(params)
      find_parent(params)
      attachment = parent.attachments.find_by!(uuid: params.delete(:id))
      attachment.destroy

      attachment
    end

    private

    def parse_file(params)
      file = params.delete(:files)
      return unless file

      params[:media_item] = file
    end
  end
end
