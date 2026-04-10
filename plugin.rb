# name: discourse-geolocation
# about: Adds geolocation functionality and social login (Facebook, Google, Kakao, Naver) to Discourse
# version: 0.2
# authors: Your Name
# url: https://github.com/your-username/discourse-geolocation

enabled_site_setting :geolocation_enabled

register_asset "stylesheets/react-component.css"
# register_asset "javascripts/discourse/components/my-custom-component.js"
# register_asset "javascripts/discourse/templates/components/my-custom-component.hbs"

require_relative "lib/auth/facebook_authenticator.rb"
require_relative "lib/auth/google_authenticator.rb"
require_relative "lib/auth/kakao_authenticator.rb"
require_relative "lib/auth/naver_authenticator.rb"

auth_provider authenticator: FacebookAuthenticator.new,
              icon: "fab-facebook"

auth_provider authenticator: GoogleAuthenticator.new,
              icon: "fab-google"

auth_provider authenticator: KakaoAuthenticator.new,
              icon: "comment"

auth_provider authenticator: NaverAuthenticator.new,
              icon: "bold"

after_initialize do
  require_dependency File.expand_path("../app/controllers/discourse_geolocation/notes_controller.rb", __FILE__)
  require_dependency File.expand_path("app/models/geo_note.rb", __dir__)

  Rails.application.config.paths["db/migrate"] << File.expand_path("db/migrate", __dir__)

  Discourse::Application.routes.append do
    post "/notes" => "discourse_geolocation/notes#create"
    get "/nearby_users" => "discourse_geolocation/notes#nearby_users"
  end
end
