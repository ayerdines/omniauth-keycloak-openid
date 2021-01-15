require 'omniauth-keycloak-openid/version'
require 'omniauth/strategies/keycloak-openid'
require 'net/http'

OmniAuth.config.add_camelization('keycloak_openid', 'KeycloakOpenID')
