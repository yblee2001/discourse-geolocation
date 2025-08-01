# name: discourse-geolocation
# about: Adds geolocation functionality to Discourse
# version: 0.1
# authors: Your Name
# url: https://github.com/your-username/discourse-geolocation

enabled_site_setting :geolocation_enabled

# register_asset "stylesheets/react-component.css"
# register_asset "javascripts/discourse/components/my-custom-component.js"
# register_asset "javascripts/discourse/templates/components/my-custom-component.hbs"

after_initialize do
  require_dependency File.expand_path("../app/controllers/discourse_geolocation/notes_controller.rb", __FILE__)
  require_dependency File.expand_path("app/models/geo_note.rb", __dir__)

  Rails.application.config.paths["db/migrate"] << File.expand_path("db/migrate", __dir__)

  Discourse::Application.routes.append do
    post "/notes" => "discourse_geolocation/notes#create"
  end
end
