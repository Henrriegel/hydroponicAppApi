require "jwt"

module JsonWebToken
    extend ActiveSupport::Concern

    SECRET_KEY = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
    #SECRET_KEY = Rails.application.secrets.secret_key_base

    def jwt_encode(payload, exp = 1.days.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def jwt_decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0] rescue 'Expired'
        HashWithIndifferentAccess.new decoded
    end
end
