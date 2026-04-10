class GoogleAuthenticator < Auth::ManagedAuthenticator
  def name
    "google_oauth2"
  end

  def enabled?
    SiteSetting.google_login_enabled
  end

  def register_middleware(omniauth)
    omniauth.provider :google_oauth2,
                       setup: lambda { |env|
                         strategy = env["omniauth.strategy"]
                         strategy.options[:client_id] = SiteSetting.google_client_id
                         strategy.options[:client_secret] = SiteSetting.google_client_secret
                         strategy.options[:scope] = "email,profile"
                       }
  end
end
