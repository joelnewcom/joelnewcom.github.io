---
---

# General

An IP address is composed of two parts: the **network prefix** in the high-order bits and the remaining bits called the **host identifier**.

- **IPv4** gives you a 32-bit address space → ~4.3 billion addresses
- **IPv6** gives you a 128-bit address space → ~340 undecillion addresses

---

# Classful Networks (A, B, C)

Before CIDR existed, IP addresses were divided into fixed classes. The class was determined by the first few bits of the address.

| Class | First bits | Range | Default mask | Networks | Hosts per network | Usage |
|---|---|---|---|---|---|---|
| **A** | `0...` | 0.0.0.0 – 127.255.255.255 | /8 (255.0.0.0) | 128 | 16,777,214 | Very large organizations |
| **B** | `10...` | 128.0.0.0 – 191.255.255.255 | /16 (255.255.0.0) | 16,384 | 65,534 | Large organizations |
| **C** | `110...` | 192.0.0.0 – 223.255.255.255 | /24 (255.255.255.0) | 2,097,152 | 254 | Small organizations |
| **D** | `1110...` | 224.0.0.0 – 239.255.255.255 | — | — | — | Multicast (no host assignment) |
| **E** | `1111...` | 240.0.0.0 – 255.255.255.255 | — | — | — | Reserved / experimental |

> **Formula:** Hosts per network = 2^(host bits) − 2
> The − 2 accounts for the **network address** (all host bits = 0) and the **broadcast address** (all host bits = 1), which can never be assigned to a host.

### Example — Class C (/24)

```
IP:   201.1.1.0
Mask: 255.255.255.0  →  24 bits network, 8 bits host
Hosts: 2^8 − 2 = 256 − 2 = 254
Network address:   201.1.1.0    (reserved)
Broadcast address: 201.1.1.255  (reserved)
Usable hosts:      201.1.1.1 – 201.1.1.254
```

### Are classful networks still used today?

**No — classful networking has been obsolete since 1993.**

The problems were:
- **Wasteful**: a company needing 300 hosts had to get a Class B (65,534 addresses), wasting ~65,000 addresses.
- **Inflexible**: blocks came in only three sizes — too small (254), too big (65,534), or way too big (16 million).
- **IPv4 exhaustion**: the rigid structure accelerated address depletion.

CIDR replaced it entirely. However, the *private address ranges* defined in that era (RFC 1918) are still universally used:

| Range | Classful origin | Common use today |
|---|---|---|
| `10.0.0.0/8` | Class A | Large private networks, cloud VPCs |
| `172.16.0.0/12` | Class B (partial) | Enterprise networks |
| `192.168.0.0/16` | Class C | Home routers, small offices |

---

# CIDR (Classless Inter-Domain Routing)

CIDR (RFC 1519, 1993) replaces fixed classes with a flexible `/prefix` notation. The prefix length tells you exactly how many bits are reserved for the **network** — the rest are available for **hosts**.

```
192.168.1.0/24
            └── 24 bits = network prefix
                8 bits  = host portion
```

## Step-by-step: how to calculate usable IPs

### Given: `192.168.1.0/24`

**Step 1 — How many bits for hosts?**
```
Total bits:    32
Network bits:  24
Host bits:     32 − 24 = 8
```

**Step 2 — Total addresses in the block**
```
2^8 = 256 addresses
```

**Step 3 — Subtract reserved addresses**
```
256 − 2 = 254 usable host addresses
```

**Step 4 — Identify the special addresses**
```
Network address:   192.168.1.0    (first — all host bits = 0, identifies the subnet)
Broadcast address: 192.168.1.255  (last  — all host bits = 1, sends to all hosts)
Usable range:      192.168.1.1 – 192.168.1.254
```

---

### Given: `198.51.100.0/22`

**Step 1 — Host bits**
```
32 − 22 = 10 host bits
```

**Step 2 — Total addresses**
```
2^10 = 1024 addresses
```

**Step 3 — Usable hosts**
```
1024 − 2 = 1022 hosts
```

**Step 4 — Address range**
```
Network address:   198.51.100.0    (reserved)
Broadcast address: 198.51.103.255  (reserved)
Usable range:      198.51.100.1 – 198.51.103.254
```

> Tip: to find the broadcast address, set all host bits to 1.
> `/22` means the last 10 bits are host bits.
> `198.51.100.0` in binary ends in `...00 00000000`
> Set all host bits to 1 → `...11 11111111` = `198.51.103.255` ✓

---

## Quick reference table

| CIDR | Host bits | Total addresses | Usable hosts | Subnet mask |
|---|---|---|---|---|
| /8 | 24 | 16,777,216 | 16,777,214 | 255.0.0.0 |
| /16 | 16 | 65,536 | 65,534 | 255.255.0.0 |
| /24 | 8 | 256 | 254 | 255.255.255.0 |
| /25 | 7 | 128 | 126 | 255.255.255.128 |
| /26 | 6 | 64 | 62 | 255.255.255.192 |
| /27 | 5 | 32 | 30 | 255.255.255.224 |
| /28 | 4 | 16 | 14 | 255.255.255.240 |
| /29 | 3 | 8 | 6 | 255.255.255.248 |
| /30 | 2 | 4 | 2 | 255.255.255.252 |
| /31 | 1 | 2 | 2* | 255.255.255.254 |
| /32 | 0 | 1 | 1* | 255.255.255.255 |

> \* `/31` is used for point-to-point links (RFC 3021) — no network/broadcast reservation needed.
> \* `/32` identifies a single host (e.g. a loopback or a static route to one IP).

---

## Why CIDR matters

- **Efficient allocation**: give a company exactly the block size they need (e.g. `/26` for 62 hosts instead of a full `/24`).
- **Route aggregation (supernetting)**: multiple smaller blocks can be summarized into one route entry, keeping routing tables manageable.
- **Foundation of the modern internet**: every cloud provider (AWS VPCs, Azure VNets, GCP subnets) uses CIDR notation exclusively.
