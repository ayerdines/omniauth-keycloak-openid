# OmniAuth::KeycloakOpenID

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

Or directly install and add to Gemfile it yourself as:

```
    $ bundle add omniauth-keycloak-openid
```

In omniauth.rb file
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :keycloak_openid, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], scope: "openid profile email", redirect_uri: 'http://localhost:3000/auth/keycloak_openid/callback'
end
```


## License

The gem currently has the [MIT License](http://opensource.org/licenses/MIT) license file included, but todate, has NOT been made available as open source.
