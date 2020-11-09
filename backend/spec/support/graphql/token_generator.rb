module GraphQL
  module TokenGenerator
    def generate_jwt_test_token(user)
      Jwt::TokenProvider.issue_token(::Users::Presenter.new(user).for_token)
    end
  end
end
