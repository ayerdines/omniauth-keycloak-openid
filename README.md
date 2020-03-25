# OmniAuth::SSO

This is a custom [OmniAuth](https://github.com/omniauth/omniauth) "provider" gem, which authenticates a user via keycloak OIDC protocol.

## Installation

Add this line to your application's Gemfile:

```
    gem 'omniauth-keycloak-openid'
```

And then execute:

```
    $ bundle
```

Or install it yourself as:

```
    $ gem install omniauth-keycloak-openid
```

## Usage

As mentioned above, this gem enables authentication through Cisco’s SSO PingFederate OAuth2 system. Access to this system, comes through the [Cisco API Console](https://apiconsole.cisco.com/). This cosole, allows a user with a CCO ID, to: 1) Register Applications, 2) Get Access Tokens, and 3) Make API Calls.

For the given authentiation server, this gem first calls the ```/as/token.oauth2``` method to authenticate the user, and then calls the ```/idp/userinfo.openid``` to obtain the user's profile.

Once the authentication server, client id, and client secret are obtained, they should be entered into the Rails /config/settings.yml file.

```
    omniauth:
      sso:
        auth_server: '<auth_server>'
        client_id: '<client_id>'
        client_secret: '<client_secret>'
```


## Atlantis Project Specifics

The OmniAuth "provider" needs to be set in the /config/initializers/omniauth.rb file. For the Atlantis project, this has been customized as follows:

```
    sso: {
      auth_server:   SSO_CONFIG['auth_server'],
      client_id:     SSO_CONFIG['client_id'],
      client_secret: SSO_CONFIG['client_secret']
    }
```    
    
In addtion, since the Atlantis project has multiple OmniAuth providers, and only the Identity provider plus "one external" provider are active per enclave (installation), the external provider needs to be set in the ```global_params``` table, in the ```param_name``` column.

```
    update global_params set param_value = "sso" where param_name = "OMNIAUTH_PROVIDER";
```

After the Rails server is restarted, the omniauth-sso provider should become active. No Angular2 UI changes are required, to transistion between providers.

## License

The gem currently has the [MIT License](http://opensource.org/licenses/MIT) license file included, but todate, has NOT been made available as open source.
