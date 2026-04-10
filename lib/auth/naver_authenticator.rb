class NaverAuthenticator < Auth::ManagedAuthenticator
  def name
    "naver"
  end

  def enabled?
    SiteSetting.naver_login_enabled
  end

  def register_middleware(omniauth)
    require_relative "../omniauth/strategies/naver"

    omniauth.provider :naver,
                       setup: lambda { |env|
                         strategy = env["omniauth.strategy"]
                         strategy.options[:client_id] = SiteSetting.naver_client_id
                         strategy.options[:client_secret] = SiteSetting.naver_client_secret
                       }
  end
end
