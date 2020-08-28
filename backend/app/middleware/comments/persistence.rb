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
      category = account.comments.find_by(uuid: params.delete(:id))
      category.update(params)

      category
    end

    def destroy(comment)
      comment.destroy
    end
  end
end
