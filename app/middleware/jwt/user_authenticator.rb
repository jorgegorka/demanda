module Jwt
  class UserAuthenticator
    class << self
      def validate(request_headers)
        @request_headers = request_headers

        begin
          payload, header = Jwt::TokenDecryptor.decrypt(token)
          return User.find_by_uuid(payload['user_id'])
        rescue => e
          return nil
        end
      end

      def token
        @request_headers['Authorization'].split(' ').last
      end
    end
  end
end
