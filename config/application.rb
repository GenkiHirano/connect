require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module MusicSns
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators do |g|
      g.assets false
      g.test_framework false
      g.test_framework :rspec,
                       controller_specs: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
  end
end
