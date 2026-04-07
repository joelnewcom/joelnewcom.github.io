---
layout: single
title: FIDO2 & WebAuthn
---

*Sources: [FIDO Alliance](https://fidoalliance.org/fido2/) · [W3C WebAuthn spec](https://www.w3.org/TR/webauthn-2/) · [passkeys.dev](https://passkeys.dev/)*

## What is FIDO2?

**FIDO2** is an open authentication standard developed by the [FIDO Alliance](https://fidoalliance.org/) and the W3C. Its goal is to replace passwords with strong, phishing-resistant, public-key-based credentials.

It consists of two pieces:

| Component | Owner | Role |
|---|---|---|
| **WebAuthn** | W3C | Browser/platform API that lets web apps talk to authenticators |
| **CTAP2** (Client-to-Authenticator Protocol) | FIDO Alliance | Protocol between the browser/OS and an external authenticator (USB key, phone, etc.) |

---

## Core idea: public-key cryptography per origin

Every credential is a **key pair** scoped to a specific *relying party* (RP — the website or app):

- The **private key** never leaves the authenticator (hardware key, TPM, Secure Enclave).
- The **public key** is registered with the server once.
- Authentication = the authenticator signs a server-issued challenge with the private key. The server verifies the signature with the stored public key.

Because the private key is tied to the exact origin (domain), **phishing is structurally impossible** — a fake domain gets a different credential and the signature will never verify on the real server.

---

## Registration flow

```
Browser / App          Authenticator          Relying Party (Server)
     |                      |                        |
     |------- 1. navigator.credentials.create() ---->|
     |<------ 2. challenge + RP info ----------------|
     |                      |                        |
     |--- 3. user gesture ->|                        |
     |        (biometric / PIN)                      |
     |                      |-- 4. generate key pair |
     |                      |    store private key   |
     |<-- 5. public key + attestation ---------------|
     |                                               |
     |------- 6. send public key + attestation ----->|
     |<------ 7. store public key, credential ID ----|
```

1. The browser/app calls `navigator.credentials.create()` to start registration.
2. The server responds with a random **challenge** and the RP ID (usually the domain).
3. The user verifies their identity locally (fingerprint, FaceID, PIN, hardware key button).
4. The authenticator generates a new **key pair** for this RP and stores the private key securely.
5. The authenticator returns the **public key** and an **attestation statement** (proof of what authenticator was used) to the browser/app.
6. The browser/app forwards the public key and attestation to the server.
7. The server stores the public key linked to the user's account.

---

## Authentication flow

```
Browser / App          Authenticator             Relying Party (Server)
     |                      |                           |
     |--- 1. navigator.credentials.get() -------------->|
     |<-- 2. challenge + allowed credential IDs --------|
     |                      |                           |
     |--- 3. user gesture ->|                           |
     |        (biometric / PIN)                         |
     |                      |-- 4. sign challenge       |
     |                         with private key         |
     |<-- 5. signature + authenticator data ------------|
     |                                                  |
     |------- 6. send assertion ----------------------->|
     |<------ 7. verify signature with public key ------|
```

No password is ever transmitted. The server only ever sees a **signature** it can verify — nothing reusable for a replay attack.

---

## Authenticator types

| Type | Examples | Where private key lives |
|---|---|---|
| **Platform authenticator** | Face ID, Touch ID, Windows Hello, Android biometrics | Device Secure Enclave / TPM |
| **Roaming authenticator** | YubiKey, FIDO2 USB/NFC/BLE security keys | Hardware security element |
| **Passkeys (synced)** | iCloud Keychain, Google Password Manager | Cloud-synced, still hardware-backed per device |

---

## Passkeys — FIDO2 for everyday users

A **passkey** is simply a FIDO2 credential that can be synced across a user's devices via the platform (Apple, Google, Microsoft). This solves the traditional hardware-key problem of "what if I lose it?" while keeping the same phishing-resistant cryptography.

- iOS/macOS: synced via iCloud Keychain (end-to-end encrypted)
- Android: synced via Google Password Manager
- Windows: Windows Hello / Microsoft Authenticator

---

## FIDO2 vs. passwords vs. TOTP

| Property | Password | TOTP (6-digit code) | FIDO2 / Passkey |
|---|---|---|---|
| Phishing resistant | ❌ | ❌ (codes can be relayed in real-time) | ✅ (origin-bound) |
| Server breach resistant | ❌ (hashes can be cracked) | Partial | ✅ (only public key stored) |
| Replay attack resistant | ❌ | Partial (short window) | ✅ (signed challenge, used once) |
| No shared secret | ❌ | ❌ | ✅ |
| User friction | Low–Medium | Medium | Low (biometric / tap) |

---

## Is FIDO2 used in mobile banking apps?

**Yes — increasingly, but with nuance.**

### Where it clearly is used
- **Step-up / transaction confirmation**: banks use the device's biometric (Face ID / fingerprint) to confirm a payment. Under the hood this is often the platform authenticator from FIDO2 / WebAuthn (or at minimum the same Secure Enclave mechanism).
- **Passkey login**: several major banks (Bank of America, PayPal, BBVA, Citi, and many European banks under PSD2) now support passkey-based login — full FIDO2 WebAuthn via the platform authenticator.
- **FIDO UAF** (the predecessor to FIDO2): many banking apps already used *FIDO UAF* (Universal Authentication Framework) before FIDO2 existed. This is why Face ID / fingerprint login in banking apps felt "native" even before passkeys — it was FIDO UAF with a vendor SDK.

### Why some banks don't use "pure" FIDO2
Banking apps are native apps, not web pages. WebAuthn is a browser API. Native apps access the same underlying platform authenticator (Secure Enclave on iOS, StrongBox / TEE on Android) but through platform-specific APIs:
- **iOS**: `ASAuthorizationController` (passkey API)
- **Android**: `CredentialManager` API

Both are FIDO2-compliant at the protocol level and the FIDO Alliance certifies them, but the integration path is different from a website using `navigator.credentials`.

### Relation to PSD2 / Strong Customer Authentication (SCA)
In Europe, PSD2 requires SCA (two of: something you know, have, are). FIDO2 with a biometric on a registered device satisfies *both* "something you have" (the device with the private key) and "something you are" (the biometric) — making it an ideal SCA mechanism.

---

## Summary

- FIDO2 = WebAuthn (browser API) + CTAP2 (external authenticator protocol)
- Based on public-key cryptography: private key never leaves the device
- Credentials are **origin-bound** → structurally phishing-proof
- Passkeys are FIDO2 credentials synced across devices for convenience
- Used in mobile banking via platform authenticator APIs (same crypto, different API surface)
- Satisfies PSD2 Strong Customer Authentication requirements in Europe


