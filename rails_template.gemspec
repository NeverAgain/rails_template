$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_template/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_template"
  s.version     = RailsTemplate::VERSION
  s.authors     = ["Edward Zhang"]
  s.email       = ["edwardforcpu@gmail.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
end
