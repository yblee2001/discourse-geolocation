require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Kakao < OmniAuth::Strategies::OAuth2
      option :name, "kakao"

      option :client_options,
             site: "https://kapi.kakao.com",
             authorize_url: "https://kauth.kakao.com/oauth/authorize",
             token_url: "https://kauth.kakao.com/oauth/token"

      uid { raw_info["id"].to_s }

      info do
        account = raw_info["kakao_account"] || {}
        profile = account["profile"] || {}
        {
          name: profile["nickname"],
          email: account["email"],
          image: profile["profile_image_url"],
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get("/v2/user/me").parsed
      end
    end
  end
end
