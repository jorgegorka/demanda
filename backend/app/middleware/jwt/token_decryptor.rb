module Jwt
  class TokenDecryptor
    class << self
      def decrypt(token)
        begin
          JWT.decode(token, Rails.application.secrets.secret_key_base)
        rescue
           raise InvalidTokenError
        end
      end
    end
  end
end

class InvalidTokenError < StandardError; end;
