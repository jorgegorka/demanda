module GraphQL
  module TokenGenerator
    def generate_jwt_test_token(user)
      Jwt::TokenProvider.issue_token(user_id: user.uuid, role: user.role, account_id: user.account.uuid)
    end
  end
end
