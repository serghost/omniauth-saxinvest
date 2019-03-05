require "omniauth/saxinvest/version"
require 'omniauth-oauth2'

module Omniauth
  module Strategies
    class SaxInvest < OmniAuth::Strategies::OAuth2
      
      option :name, :saxinvest

      option :client_options, {
               :site => "http://localhost:3000",
               :authorize_url => "/oauth/authorize"
             }

      uid { raw_info["id"] }

      info do
        {
          :email => raw_info["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/me.json').parsed
      end

      # https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
