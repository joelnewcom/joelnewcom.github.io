---
layout: single
title: JSON Web Tokens (JWT)
---

*Sources: [RFC 7519 – JWT](https://datatracker.ietf.org/doc/html/rfc7519) · [RFC 7517 – JWK](https://datatracker.ietf.org/doc/html/rfc7517) · [SuperTokens – Understanding JWKS](https://supertokens.com/blog/understanding-jwks)*

---

## What is a JWT?

A **JSON Web Token (JWT)** is a compact, URL-safe token that encodes a set of *claims* as a JSON object and optionally signs or encrypts them.
It is the dominant token format in OAuth 2.0 / OIDC flows — both access tokens and ID tokens are typically JWTs.

---

## Structure

A JWT is three Base64url-encoded parts separated by dots:

```
eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImFiYzEyMyJ9   ← Header
.eyJzdWIiOiJ1c2VyXzQyIiwiaXNzIjoiaHR0cHM6Ly9pZHAuZXhhbXBsZS5jb20iLCJhdWQiOiJteS1hcGkiLCJleHAiOjE3NDQwMDAwMDAsImlhdCI6MTc0Mzk5NjQwMH0   ← Payload
.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c   ← Signature
```

### 1. Header

```json
{
  "alg": "RS256",
  "typ": "JWT",
  "kid": "abc123"
}
```

| Field | Description |
|---|---|
| `alg` | Signing algorithm (`RS256`, `ES256`, `HS256`, …) |
| `typ` | Token type — always `JWT` |
| `kid` | Key ID — tells the receiver *which* key to use for verification |

### 2. Payload (Claims)

```json
{
  "sub":   "user_42",
  "iss":   "https://idp.example.com",
  "aud":   "my-api",
  "exp":   1744000000,
  "iat":   1743996400,
  "email": "alice@example.com",
  "roles": ["admin"]
}
```

| Claim | Meaning |
|---|---|
| `sub` | Subject — who the token is about |
| `iss` | Issuer — who created the token |
| `aud` | Audience — who the token is intended for |
| `exp` | Expiry timestamp (Unix epoch) |
| `iat` | Issued-at timestamp |
| `nbf` | Not-before timestamp (optional) |
| `jti` | Unique token ID, useful for revocation |

Everything else (`email`, `roles`, …) are **custom claims** added by the authorization server.

> ⚠️ The payload is only Base64url-encoded, **not encrypted**. Anyone can decode and read it. Never put secrets in a JWT payload unless the token is also encrypted (JWE).

### 3. Signature

```
RSASHA256(
  base64url(header) + "." + base64url(payload),
  privateKey
)
```

The signature guarantees that the token was issued by the party holding the private key and that neither the header nor the payload has been tampered with since.

---

## Signing algorithms

| Algorithm | Type | Notes |
|---|---|---|
| **RS256** | RSA + SHA-256 (asymmetric) | Most common in OAuth/OIDC. Private key signs, public key verifies. |
| **ES256** | ECDSA + SHA-256 (asymmetric) | Shorter signatures, same security level as RS256. Preferred for mobile. |
| **HS256** | HMAC + SHA-256 (symmetric) | Single shared secret — both parties must know it. Avoid for public APIs. |
| **RS512 / ES512** | Same as above, SHA-512 | Higher security margin, larger tokens. |

For public APIs and OAuth flows, always prefer **asymmetric** algorithms (RS256 / ES256). The authorization server keeps its private key secret; any API can verify with the public key without ever seeing the private key.

---

## How JWT validation should work

Accepting a JWT is not just decoding it. A receiver **must** perform all of these checks:

### Step 1 — Structural check
Split on `.` and verify there are exactly three parts, each valid Base64url.

### Step 2 — Fetch the public key via JWKS
The issuer publishes its public keys at a well-known endpoint:

```
GET https://idp.example.com/.well-known/jwks.json
```

A **JWKS (JSON Web Key Set)** response looks like:

```json
{
  "keys": [
    {
      "kty": "RSA",
      "use": "sig",
      "kid": "abc123",
      "alg": "RS256",
      "n":   "0vx7agoebGcQSuuPiLJXZptN9nndrQmbXEps2...",
      "e":   "AQAB"
    }
  ]
}
```

| Field | Meaning |
|---|---|
| `kty` | Key type (`RSA`, `EC`, `oct`) |
| `use` | Intended use: `sig` (signature) or `enc` (encryption) |
| `kid` | Key ID — match this against the `kid` in the JWT header |
| `n`, `e` | RSA modulus and exponent (public key material) |

**Match the `kid` from the JWT header to the correct key in the JWKS.** If no `kid` is present, the receiver may try all keys — but this is fragile.

> 💡 Cache the JWKS response (respect `Cache-Control`), but re-fetch when you encounter an unknown `kid`. Authorization servers rotate keys; hard-coding them is an operational risk.

### Step 3 — Verify the signature
Reconstruct `base64url(header) + "." + base64url(payload)` and verify the signature using the fetched public key and the algorithm declared in the header.

**Never trust the `alg` field from the token alone** — always enforce the expected algorithm on your side. The classic attack is sending `"alg": "none"` to bypass signature verification.

### Step 4 — Validate the claims

| Check | What to verify |
|---|---|
| `exp` | Token is not expired (`exp > now`) |
| `nbf` | Token is already valid (`nbf <= now`) |
| `iss` | Matches the expected issuer URL exactly |
| `aud` | Contains your API's identifier |
| `alg` (header) | Matches the algorithm your service expects — reject anything else |

### Step 5 — Check revocation (optional but recommended)
JWTs are stateless — once issued, a valid signature passes even if the user logged out or the token was revoked. Mitigations:

- **Short expiry** (`exp`) — 5–15 minutes for access tokens is common.
- **Token introspection** — call the authorization server's `/introspect` endpoint for sensitive operations.
- **Revocation list / `jti` blocklist** — store revoked `jti` values in a fast store (Redis) and reject matches.

---

## Full validation flow

```
Receive JWT
    │
    ▼
Decode header → read kid + alg
    │
    ▼
Fetch JWKS from issuer's .well-known endpoint (use cache)
    │
    ▼
Find key where key.kid == jwt.kid
    │
    ▼
Verify signature with public key
    │
    ├── FAIL → reject (tampered or wrong issuer)
    │
    ▼
Validate claims: exp, nbf, iss, aud, alg
    │
    ├── FAIL → reject (expired, wrong audience, etc.)
    │
    ▼
(Optional) Check jti against revocation list
    │
    ▼
✅ Token accepted — trust the claims
```

---

## Common mistakes

| Mistake | Risk |
|---|---|
| Not verifying the signature | Anyone can forge a token |
| Trusting `"alg": "none"` | Signature check is skipped entirely |
| Not checking `aud` | Your API accepts tokens meant for a different service |
| Not checking `exp` | Expired tokens remain valid forever |
| Hard-coding the public key | Breaks silently when the IdP rotates keys |
| Putting secrets in the payload | Payload is readable by anyone who holds the token |

---

## JWT in the OAuth 2.0 / OIDC context

- **Access token** (OAuth 2.0): usually a JWT, used to call APIs. The API validates it locally using JWKS — no call to the authorization server needed on every request.
- **ID token** (OIDC): always a JWT, used by the client app to know who the user is. Must be validated the same way.
- **Refresh token**: typically *not* a JWT — it's an opaque string stored server-side, exchanged for a new access token.

