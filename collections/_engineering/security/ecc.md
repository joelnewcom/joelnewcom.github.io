---
layout: single
title: Elliptic Curve Cryptography (ECC)
---

# Elliptic Curve Cryptography (ECC)

ECC is an **asymmetric encryption algorithm** — just like RSA. You have a public key and a private key. The fundamental difference is *what hard mathematical problem* security is based on:

| | Hard Problem | Key Size for ~128-bit security |
|-|-------------|-------------------------------|
| RSA | Factoring large integers | 3072 bit |
| ECC | Elliptic Curve Discrete Logarithm Problem (ECDLP) | 256 bit |

Same security. 12× smaller key. Much faster. This is why ECC dominates modern TLS, SSH, and JWT signing.

---

## What Is an Elliptic Curve?

An elliptic curve is defined by the equation:

```
y² = x³ + ax + b
```

It looks nothing like an ellipse — the name is historical. What matters is its shape: a smooth curve symmetric around the x-axis.

The key operation is **point addition**: given two points P and Q on the curve, you can compute a third point P+Q by drawing a line through them, finding where it intersects the curve, and reflecting that point across the x-axis. This is easy to compute forward but hard to reverse — that asymmetry is the foundation of ECC security.

---

## The Intuition — Color Mixing

The same color mixing analogy from RSA applies here perfectly.

```
Public color (known to everyone):  🟡 Yellow   (the public curve + base point G)
Alice's secret color:              🔵 Blue      (Alice's private key a)
Bob's secret color:                🔴 Red       (Bob's private key b)
```

**Step 1 — Each party mixes their private color with the public color:**

```
Alice sends to Bob:  🟡 + 🔵 = 🟢 Green   (Alice's public key: A = a×G)
Bob sends to Alice:  🟡 + 🔴 = 🟠 Orange  (Bob's public key:   B = b×G)
```

**Step 2 — Each party mixes the received color with their own private color:**

```
Alice: 🟠 + 🔵 = 🟤 Brown  →  a×B = a×(b×G) = ab×G  ← shared secret
Bob:   🟢 + 🔴 = 🟤 Brown  →  b×A = b×(a×G) = ab×G  ← same shared secret
```

An attacker sees `G`, `A = a×G` and `B = b×G` on the wire. To get the shared secret they would need to compute `a` from `a×G` — this is the **Elliptic Curve Discrete Logarithm Problem (ECDLP)** and is computationally infeasible for large curves.

This specific key exchange protocol is called **ECDH (Elliptic Curve Diffie-Hellman)**.

---

## ECC Step by Step — Party A sends a message to Party B

### 1. Agree on a public curve

Both parties use the same publicly known curve parameters:
- The curve equation (`a`, `b`)
- A base point `G` on the curve (a specific agreed starting point)
- The order `n` of the base point (how many times you can add G to itself)

Common standardized curves: `P-256` (NIST), `Curve25519` (modern default), `secp256k1` (Bitcoin).

### 2. Bob generates his key pair

- Pick a random integer `b` → this is Bob's **private key** (keep secret)
- Compute `B = b × G` → this is Bob's **public key** (share freely)

The `×` here means repeated point addition on the curve, not regular multiplication.

```
Bob  ──── public key B = b×G ────►  Alice
```

### 3. Alice generates a session key pair

For each message, Alice picks a random integer `k`:
- Computes `R = k × G` (a temporary public point)
- Computes the shared secret `S = k × B = k×b×G`
- Derives a symmetric encryption key from `S` (e.g. via SHA-256)

### 4. Alice encrypts her message

Alice encrypts the message `M` using the derived symmetric key (AES in practice):

```
C = AES_encrypt(key=hash(S), plaintext=M)
```

Alice sends both `R` and `C` to Bob.

```
Alice  ──── (R, C) ────►  Bob
```

### 5. Bob decrypts the message

Bob computes the same shared secret using his private key:

```
S = b × R = b×k×G  (same as Alice's k×b×G ✓)
```

Bob derives the same symmetric key from `S` and decrypts:

```
M = AES_decrypt(key=hash(S), ciphertext=C)
```

This variant is called **ECIES (Elliptic Curve Integrated Encryption Scheme)**.

---

## Full Flow at a Glance

```
Bob                                            Alice
 │                                               │
 │── generates key pair b, B=b×G                 │
 │── shares public key B ──────────────────────► │
 │                                               │── picks random k
 │                                               │── R = k×G
 │                                               │── S = k×B  (shared secret)
 │                                               │── C = AES(hash(S), M)
 │◄──────────────── sends (R, C) ─────────────── │
 │── S = b×R  (same shared secret)               │
 │── M = AES_decrypt(hash(S), C)                 │
 │── reads message M                             │
```

---

## ECC for Signing — ECDSA

ECC is not only used for encryption — it is more commonly used for **digital signatures** (proving a message came from you).

The algorithm is **ECDSA (Elliptic Curve Digital Signature Algorithm)**:

1. Alice has private key `a`, public key `A = a×G`
2. Alice signs a message `M`:
   - Hash the message: `h = SHA256(M)`
   - Pick random `k`, compute `R = k×G`
   - Compute signature `s = k⁻¹ × (h + a×Rₓ) mod n`
   - Send `(M, signature=(Rₓ, s))`
3. Bob verifies using Alice's **public key** `A` — no private key needed to verify

This is how JWT tokens are signed (`ES256`), how TLS certificates work, and how Git commit signing works.

---

## Common Curves

| Curve | Also Known As | Key Size | Used In |
|-------|--------------|----------|---------|
| P-256 | secp256r1, prime256v1 | 256 bit | TLS, JWT (ES256), FIDO2 |
| P-384 | secp384r1 | 384 bit | High-security TLS |
| Curve25519 | X25519 (for ECDH) | 255 bit | TLS 1.3, SSH, Signal Protocol |
| Ed25519 | EdDSA on Curve25519 | 255 bit | SSH keys, Git signing, JWT (EdDSA) |
| secp256k1 | — | 256 bit | Bitcoin, Ethereum |

**Curve25519 / Ed25519** are the modern default. They were designed to be faster, safer to implement, and resistant to timing attacks. If you are generating a new SSH key today, use `ssh-keygen -t ed25519`.

---

## Key Size Comparison

| Algorithm | Key Size | Equivalent Security |
|-----------|----------|-------------------|
| RSA | 2048 bit | ~112 bit security |
| RSA | 3072 bit | ~128 bit security |
| ECC | 256 bit | ~128 bit security |
| ECC | 384 bit | ~192 bit security |

Same protection. Fraction of the size. ECC handshakes are significantly faster — critical for mobile, IoT, and high-traffic HTTPS servers.

---

## ECC vs RSA — When to Use Which

| Situation | Recommendation |
|-----------|---------------|
| New system, greenfield | ✅ ECC (Ed25519 or P-256) |
| Existing RSA infrastructure | RSA 2048+ is fine, migrate when convenient |
| Legacy systems / compliance | RSA (wider support) |
| SSH keys | ✅ Ed25519 |
| TLS certificates | ✅ P-256 or P-384 |
| JWT signing | ✅ ES256 (P-256) or EdDSA |
| Bitcoin/blockchain | secp256k1 (no choice) |
| Post-quantum future | Neither — watch NIST PQC standards (CRYSTALS-Kyber, CRYSTALS-Dilithium) |

---

## The Post-Quantum Caveat

Both RSA and ECC are broken by **Shor's algorithm** running on a sufficiently large quantum computer. Quantum computers of that scale do not exist yet (as of 2026), but NIST finalized the first **Post-Quantum Cryptography (PQC)** standards in 2024:

- **CRYSTALS-Kyber** → key encapsulation (replaces ECDH)
- **CRYSTALS-Dilithium** → digital signatures (replaces ECDSA)

For most enterprise systems, ECC is still the right choice today — but keep an eye on PQC adoption in TLS and certificate authorities over the next few years.

