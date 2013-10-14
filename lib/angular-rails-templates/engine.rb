module AngularRailsTemplates
  class Engine < ::Rails::Engine
    config.angular_templates = ActiveSupport::OrderedOptions.new
    config.angular_templates.module_name = 'templates'

    config.before_initialize do |app|
      Sprockets::Engines #force autoloading
      Sprockets.register_engine '.ajs', AngularRailsTemplates::Template
      Sprockets.register_engine '.html', AngularRailsTemplates::Template
    end

    config.after_initialize do |app|
      path = AngularRailsTemplates.base_path.presence || "#{app.root}/app/assets/javascripts/"
      config.angular_templates.base_path = File.join(path,'')
    end
  end
end
