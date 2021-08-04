module Jwt
  class UserAuthenticator
    class << self
      def validate(request_headers)
        @request_headers = request_headers

        payload, _header = Jwt::TokenDecryptor.decrypt(token)
        User.find_by(uuid: payload['user_id'])
      end

      def token
        return unless @request_headers['Authorization']

        @request_headers['Authorization'].split(' ').last
      end
    end
  end
end
