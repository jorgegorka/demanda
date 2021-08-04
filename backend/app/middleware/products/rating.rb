module Products
  class Rating
    def initialize(product)
      @product = product
    end

    def update
      product.update(rating: rating)
    end

    private

    attr_reader :account, :product

    def comments
      @comments ||= product.comments.approved.with_rating
    end

    def rating
      return 0 if comments.size.zero?

      rating = comments.reduce(0) { |total, comment| total + (comment.rating * 20) }

      (rating / comments.size).round
    end
  end
end
