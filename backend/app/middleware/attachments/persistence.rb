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

    def destroy(attachment)
      attachment.media_item.purge
      attachment.destroy
    end

    private

    def parse_file(params)
      params[:media_item] = params.delete(:files)
    end
  end
end
