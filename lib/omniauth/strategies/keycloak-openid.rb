require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class KeycloakOpenID < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = "openid profile email"
      DEFAULT_RESPONSE_TYPE = "code"

      option :name, 'keycloak_openid'
      option :client_options, site: 'http://localhost:8080'

      option :authorize_options, %i[scope response_type redirect_uri]
      option :provider_ignores_state, true

      uid { raw_info['user'] }

      info do
        {
          name: raw_info['name'] || "#{raw_info['given_name']} #{raw_info['family_name']}",
          email: raw_info['email'],
          first_name: raw_info['given_name'],
          last_name: raw_info['family_name'],
          phone: raw_info['phone_number']
        }
      end

      extra do
        prune!('raw_info' => raw_info)
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def raw_info
        @raw_info ||= load_identity
      end

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
          params[:response_type] ||= DEFAULT_RESPONSE_TYPE
        end
      end

      def build_access_token
        if options[:grant_type] == 'auth_code'
          verifier = request.params['code']
          client.auth_code.get_token(verifier, get_token_options(callback_url), deep_symbolize(options.auth_token_params))
        else
          client.password.get_token(request.params[:username],
                                    request.params[:password],
                                    scope: DEFAULT_SCOPE)
        end
      end

      private

      def load_identity
        access_token.options[:mode] = :header
        access_token.options[:param_name] = :access_token
        access_token.options[:grant_type] = :authorization_code
        access_token.get(options[:userinfo_url]).parsed || {}
      end

      def get_token_options(redirect_uri)
        { redirect_uri: redirect_uri }.merge(token_params.to_hash(symbolize_keys: true))
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
