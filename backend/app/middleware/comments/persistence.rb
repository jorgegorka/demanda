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
      comment = parent.comments.create(params)

      comment
    end

    def update(params)
      category = Comment.for_account(account.id).where(uuid: params.delete(:id)).first
      category.update(params)

      category
    end

    def destroy(comment)
      comment.destroy
    end
  end
end
