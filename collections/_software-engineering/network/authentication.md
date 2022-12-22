---
layout: single
---


# SAML 2.0
Open standard for passing authentication and authorization information between three actors:
* the principal
* the service provider
* the identity provider

The standard enforces the use of XML-based messages to pass information (security assertions) between the service provider and the identity provider.
SAML enables SSO in form of a browser session cookie.  

# OAuth 2.0
It is meant for delegated authority. This standard only covers authorization to a resource. 
User (Resource owner) logs in into the authorization server to delegate access to the client (custom application) for the resource on the resource server.
The authorization server issues JWT token (access token, could also be another format) to the client.

There are different flows to support mutiple scenarios:
https://developer.okta.com/docs/concepts/oauth-openid/#what-kind-of-client-are-you-building


# OpenId Connect (OIDC)
Builds up on OAuth 2.0 and adds the missing authentication layer in Oauth. It also defines the JWT token as standard.
Adds an User Info endpoint service, so the client can get user infos if needed. With this the userinfo don't need to reside in the token anymore. 