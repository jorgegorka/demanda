module Attachments
  class Persistence
    include Shared::ParentManager

    attr_reader :account, :parent

    def initialize(account)
      @account = account
    end

    def create(params)
      find_parent(params)
      attachment = parent.attachments.create(params)

      attachment
    end

    def destroy(params)
      find_parent(params)
      attachment = parent.attachments.find_by(uuid: params.delete(:id))
      attachment.destroy

      attachment
    end
  end
end
