require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    def prepare; end

    def evaluate(scope, locals, &block)
      <<-EOS
angular.module(#{module_name.inspect}, []).run(["$templateCache",function($templateCache) {
  $templateCache.put(#{template_name.inspect}, #{data.to_json});
}]);

if (typeof window.AngularRailsTemplates === 'undefined') {
  window.AngularRailsTemplates = [];
}
window.AngularRailsTemplates.push(#{module_name.inspect});
      EOS
    end

    private

    def module_name
      @module_name ||= "#{configuration.module_name}-#{template_name}"
    end

    def template_name
      @template_name ||= (
       f = file.gsub(configuration.base_path, '')

      paths = f.split(File::SEPARATOR)
      paths[-1] = paths.last.split('.').first

      paths.join(File::SEPARATOR) + '.html')
    end

    def configuration
      ::Rails.configuration.angular_templates
    end
  end
end
