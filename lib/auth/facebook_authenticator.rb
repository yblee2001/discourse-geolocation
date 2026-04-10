class FacebookAuthenticator < Auth::ManagedAuthenticator
  def name
    "facebook"
  end

  def enabled?
    SiteSetting.facebook_login_enabled
  end

  def register_middleware(omniauth)
    omniauth.provider :facebook,
                       setup: lambda { |env|
                         strategy = env["omniauth.strategy"]
                         strategy.options[:client_id] = SiteSetting.facebook_app_id
                         strategy.options[:client_secret] = SiteSetting.facebook_app_secret
                         strategy.options[:scope] = "email"
                         strategy.options[:info_fields] = "name,email"
                       }
  end
end
