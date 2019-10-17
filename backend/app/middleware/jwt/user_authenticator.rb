module Jwt
  class UserAuthenticator
    class << self
      def validate(request_headers)
        @request_headers = request_headers


        begin
          payload, _header = Jwt::TokenDecryptor.decrypt(token)
          return User.find_by(uuid: payload['user_id'])
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
