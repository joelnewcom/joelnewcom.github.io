---
layout: single
title: OAuth 2.0 & OpenID Connect
---

*Summary based on [Okta Developer Docs](https://developer.okta.com/docs/concepts/oauth-openid/)*

## OAuth 2.0 vs. OpenID Connect

**OAuth 2.0** controls and delegates *authorization* to access a protected resource (web app, native app, API). It provides API security through scoped access tokens.

**OpenID Connect (OIDC)** extends OAuth 2.0 with user *authentication*. It adds an ID token type and standardizes scopes, endpoint discovery, and dynamic client registration.

> In short: OAuth 2.0 = "what can you access?", OIDC = "who are you?"

**A note on SSO:** Okta's docs say OIDC "adds SSO functionality", but that framing is a bit misleading. SSO is not a protocol — it's an outcome. It works whenever multiple apps share the same Identity Provider (IdP) session, regardless of whether you use OAuth 2.0 alone or OIDC.
What OIDC actually contributes to SSO is the **ID token**: a standardized, verifiable way for each app to know *who* the already-authenticated user is, without re-prompting for credentials. Pure OAuth 2.0 can participate in SSO too (the browser session at the IdP is the same), but it only returns an opaque access token — apps have no standard way to read user identity from it. OIDC closes that gap.

---

## Key Roles & Terms

| Term | Description |
|---|---|
| **Client** | The app requesting access to data |
| **Resource Server** | The API / app storing the data |
| **Resource Owner** | The end user who owns the data |
| **Authorization Server** | Issues tokens (e.g. Okta) |
| **Access Token** | Token used to access the resource server |
| **Refresh Token** | Optional token used to obtain a new access token |
| **ID Token** | OIDC token containing end-user claims |

---

## Choosing an OAuth 2.0 Flow

### By application type

| App type | Recommended flow | Access Token | ID Token |
|---|---|---|---|
| Server-side (web), SPA, Native | **Authorization Code with PKCE** | ✅ | ✅ |
| Trusted first-party app | **Interaction Code** *(Identity Engine only)* | ✅ | ✅ |
| Machine-to-machine service | **Client Credentials** | ✅ | ❌ |

### Decision flowchart

1. **Is the client public?** (SPA, mobile, native — source code visible)
   - Yes → use **Authorization Code with PKCE** (redirect) or **Interaction Code** (embedded)
   - No (server-side / desktop) → continue below

2. **Does it have an end user?**
   - No → use **Client Credentials** (machine-to-machine)
   - Yes → continue below

3. **Is the app high-trust** (you own both client and resource)?
   - Yes, and no MFA needed → **Resource Owner Password** (last resort only)
   - No / MFA required → **Authorization Code with PKCE**

---

## Flow Details

### Authorization Code with PKCE *(recommended)*
- Works for every client type (SPA, mobile, server-side).
- The app generates a **code verifier** → hashes it into a **code challenge** → sends the challenge with the authorization request.
- The server returns an authorization code; the client exchanges it plus the original verifier for an access token.
- Prevents authorization code injection attacks.

### Interaction Code *(Identity Engine only)*
- Extension of OAuth 2.0 / OIDC for **embedded** authentication flows (the app hosts its own sign-in UI).
- Requires client ID and PKCE parameters.

### Client Credentials
- For **server-side apps with no end user** (machine-to-machine).
- Single authenticated request to `/token` → access token returned.
- Does **not** support refresh tokens.

### Resource Owner Password
- Client collects and sends user credentials directly to the authorization server.
- Only viable when you own both the client and the resource, and MFA is not needed.
- **Not recommended** — prefer Authorization Code or Interaction Code flows.

### SAML 2.0 Assertion
- For clients that already have a trust relationship via SAML and want to exchange a SAML assertion for an OAuth access token.
- Useful for accessing APIs that only support delegated permissions without re-prompting the user.

### Implicit *(legacy)*
- Originally for browser-based apps that couldn't support CORS or PKCE.
- Access token returned directly in the redirect from `/authorize` — no `/token` call.
- Does **not** support refresh tokens.
- **Deprecated** — use Authorization Code with PKCE for all SPAs running in modern browsers.

