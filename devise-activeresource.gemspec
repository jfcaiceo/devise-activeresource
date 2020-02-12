$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require 'devise/activeresource/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'devise-activeresource'
  spec.version     = Devise::Activeresource::VERSION
  spec.authors     = ['Francisco Caiceo']
  spec.email       = ['jfcaiceo55@gmail.com']
  spec.homepage    = 'https://github.com/jfcaiceo/devise-activeresource'
  spec.summary     = 'Support for using Active Resource with Devise'
  spec.description = 'Plugin to use Active Resource in Devise'
  spec.license     = 'MIT'

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'activeresource', '~> 5.1.0'
  spec.add_dependency 'devise', '>= 4.7.1', '< 5'
  spec.add_dependency 'rails', '>= 5.0.0', '< 7'
end
