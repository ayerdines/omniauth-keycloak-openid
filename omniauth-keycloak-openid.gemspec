# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-keycloak-openid/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-keycloak-openid"
  spec.version       = OmniAuth::KeycloakOpenID::VERSION
  spec.authors       = ["Dinesh Budhayer"]
  spec.email         = ["budhayer96d@gmail.com"]

  spec.summary       = %q{Keycloak OpenID Connect supporting strategy for Omniauth.}
  spec.description   = %q{This gem authenticates a user by Keycloak OpenID connect protocol.}
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/ayerdines/omniauth-keycloak-openid"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth', '~> 1.1', '>= 1.1.1'
  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.3', '>= 1.3.1'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency "rspec", "~> 3.0"
end
