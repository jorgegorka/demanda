# frozen_string_literal: true

module Comments
  class Persistence
    include Shared::ParentManager

    attr_reader :account, :parent

    def initialize(account)
      @account = account
    end

    def create(params)
      find_parent(params)
      params[:account_id] = account.id
      comment = parent.comments.create(params)

      comment
    end

    def update(params)
      comment = account.comments.find_by(uuid: params.delete(:id))
      comment.update(params)

      comment
    end

    def destroy(comment)
      comment.destroy
    end
  end
end
