require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Naver < OmniAuth::Strategies::OAuth2
      option :name, "naver"

      option :client_options,
             site: "https://openapi.naver.com",
             authorize_url: "https://nid.naver.com/oauth2.0/authorize",
             token_url: "https://nid.naver.com/oauth2.0/token"

      uid { raw_info["id"] }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"],
          image: raw_info["profile_image"],
          nickname: raw_info["nickname"],
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= begin
          response = access_token.get("/v1/nid/me").parsed
          response["response"] || {}
        end
      end
    end
  end
end
