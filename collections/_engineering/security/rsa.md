---
layout: single
title: RSA
---

# RSA Encryption

RSA is an **asymmetric encryption algorithm**. Asymmetric means there are two different keys — one to encrypt, one to decrypt. You can share the encryption key with the entire world (the **public key**) and keep only the decryption key secret (the **private key**).

---

## The Intuition — Color Mixing

Imagine encryption like mixing paint colors. The trick with colors is:

- Mixing is **easy** — anyone can do it
- **Un-mixing** is practically impossible — you cannot separate colors back out

```
Public color (known to everyone):  🟡 Yellow
Alice's secret color:              🔵 Blue  (private, never shared)
Bob's secret color:                🔴 Red   (private, never shared)
```

**Step 1 — Each party mixes their private color with the public color:**

```
Alice sends to Bob:  🟡+🔵 = 🟢 Green
Bob sends to Alice:  🟡+🔴 = 🟠 Orange
```

**Step 2 — Each party mixes the received color with their own private color:**

```
Alice: 🟠 + 🔵 = 🟤 Brown  ← shared secret
Bob:   🟢 + 🔴 = 🟤 Brown  ← same shared secret
```

An attacker only ever sees 🟡, 🟢 and 🟠 on the wire. They cannot reconstruct 🟤 without knowing either 🔵 or 🔴. This is exactly how **Diffie-Hellman key exchange** works — and it is the mathematical foundation RSA builds on.

---

## RSA Step by Step — Party A sends a message to Party B

### 1. Bob generates his key pair

Bob runs a key generation algorithm once. It produces:

- **Public key** `(e, n)` — Bob publishes this everywhere. Anyone can have it.
- **Private key** `(d, n)` — Bob keeps this secret forever.

The math behind it (simplified):
1. Pick two large prime numbers: `p` and `q`
2. Compute `n = p × q` (the modulus — this is public)
3. Compute `φ(n) = (p-1) × (q-1)` (Euler's totient — kept secret)
4. Choose `e` such that `1 < e < φ(n)` and `gcd(e, φ(n)) = 1` (typically `e = 65537`)
5. Compute `d` such that `d × e ≡ 1 (mod φ(n))` — this is the private exponent

The security relies on the fact that factoring `n` back into `p` and `q` is **computationally infeasible** for large numbers (2048+ bits).

### 2. Bob shares his public key with Alice

Bob puts his public key `(e, n)` on a server, in a certificate, or just hands it to Alice.  
Alice does **not** need to trust a secure channel for this — the public key is, well, public.

```
Bob  ──── public key (e, n) ────►  Alice
```

### 3. Alice encrypts her message

Alice has a plaintext message `M` (must be smaller than `n`).

She computes the ciphertext:

```
C = M^e mod n
```

- `M` = the original message (as a number)
- `e` = Bob's public exponent
- `n` = Bob's modulus
- `C` = encrypted ciphertext — this is what Alice sends

Without `d`, reversing this is as hard as factoring `n`. Even Alice herself cannot decrypt `C` anymore.

### 4. Alice sends the ciphertext to Bob

```
Alice  ──── C (ciphertext) ────►  Bob
```

This can go over any insecure channel — email, HTTP, a postcard. It doesn't matter. Without Bob's private key `d`, it is useless.

### 5. Bob decrypts the message

Bob uses his private key `d`:

```
M = C^d mod n
```

Because of how `d` was chosen (`d × e ≡ 1 mod φ(n)`), this perfectly reverses the encryption and recovers the original `M`.

---

## Full Flow at a Glance

```
Bob                                          Alice
 │                                             │
 │── generates key pair (e,n) and (d,n) ──►   │
 │── shares public key (e, n) ──────────────► │
 │                                             │── C = M^e mod n
 │◄──────────────── sends C ─────────────────  │
 │── M = C^d mod n                             │
 │── reads message M                           │
```

---

## Why Not Always Use RSA Directly?

RSA is **slow** for large data. In practice:

1. Alice generates a random **symmetric key** (e.g. AES-256)
2. Alice encrypts the **symmetric key** with Bob's RSA public key
3. Alice encrypts the **actual message** with the fast symmetric key
4. Bob decrypts the symmetric key using his RSA private key
5. Bob decrypts the message using the symmetric key

This is called a **hybrid encryption scheme** and is exactly what TLS (HTTPS) does.

---

## Key Sizes

| Key Size | Security Level | Use Case |
|----------|---------------|----------|
| 1024 bit | ❌ Broken | Do not use |
| 2048 bit | ✅ Acceptable | Minimum for new systems |
| 3072 bit | ✅ Good | Recommended |
| 4096 bit | ✅ Strong | High security, slower |

---

## RSA vs Elliptic Curve (ECC)

RSA is old (1977). Modern systems increasingly prefer **ECC** (Elliptic Curve Cryptography) which achieves the same security with much smaller keys — a 256-bit ECC key is roughly equivalent to a 3072-bit RSA key. Smaller keys = faster handshakes = less CPU on mobile/IoT devices.
