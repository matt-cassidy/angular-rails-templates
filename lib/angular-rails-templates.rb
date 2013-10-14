module AngularRailsTemplates

  autoload :Template, 'angular-rails-templates/template'
  autoload :Version,  'angular-rails-templates/version'

  mattr_accessor :base_path
end

require 'angular-rails-templates/engine'
