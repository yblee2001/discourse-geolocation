class KakaoAuthenticator < Auth::ManagedAuthenticator
  def name
    "kakao"
  end

  def enabled?
    SiteSetting.kakao_login_enabled
  end

  def register_middleware(omniauth)
    require_relative "../omniauth/strategies/kakao"

    omniauth.provider :kakao,
                       setup: lambda { |env|
                         strategy = env["omniauth.strategy"]
                         strategy.options[:client_id] = SiteSetting.kakao_client_id
                         strategy.options[:client_secret] = SiteSetting.kakao_client_secret
                       }
  end
end
