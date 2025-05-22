module RailsFakeApi
  class Engine < ::Rails::Engine
    isolate_namespace RailsFakeApi
    engine_name 'rails_fake_api'

    initializer "rails_fake_api.add_controllers" do |app|
      app.config.autoload_paths += %W(#{config.root}/app/controllers)
    end

    config.generators.api_only = true
  end
end
