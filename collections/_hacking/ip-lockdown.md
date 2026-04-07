---
layout: single
title: "IP Lockdown"
excerpt: "How to ensure an application is only reachable through a WAF/firewall and not directly via its origin IP."
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

When you put an application behind a Web Application Firewall (WAF) like Imperva/Incapsula, the WAF filters all incoming traffic. 
But by default, the origin server is still **publicly reachable on its own IP** — completely bypassing the WAF. 
An IP lockdown ensures that **only traffic coming from the WAF's IP ranges** can reach the origin.

## Why it matters

**Scenario 1 — Insecure (no lockdown):**
```
User        →  WAF  →  Origin ✅
Bad Actor   ──────────► Origin ✅  (bypasses WAF completely)
```
A bad actor who knows the origin IP can send malicious requests directly, skipping all WAF security rules.

**Scenario 2 — Secure (lockdown in place):**
```
User        →  WAF  →  Origin ✅
Bad Actor   ──────────► Origin ❌  (blocked by firewall rules)
```
Access rules on the origin only allow traffic from the WAF's trusted IP ranges. Direct access is blocked.

---

## How to lock down the origin IP

### Option 1 — On-premise / data centre IP
The firewall team manages the access rules.
Open a ticket and include:
- The IP or hostname to protect
- A comment: *"Please add IP/Hostname to the Imperva/Incapsula protected rule to allow access from only trusted IPs"*

### Option 2 — Third-party / cloud infrastructure (e.g. Azure, AWS)
Configure a network security rule on your infrastructure to **only allow inbound traffic from the IP ranges** listed below.

---

## How to test if the origin is still directly accessible

These bash commands help verify whether the lockdown is effective.

### 1. Resolve the origin IP (bypassing DNS that may point to the WAF)
```bash
# Look up what IP the domain resolves to (this may be the WAF, not the origin)
dig +short yourdomain.com

# If you know the origin hostname directly, resolve that
dig +short origin.yourdomain.com
```

> **Why does `dig` sometimes return a different IP than `nslookup`?**
>
> `nslookup` uses the OS resolver (the same one your browser uses), which respects your system's configured DNS server — often your router or a corporate DNS. That DNS may apply **split-horizon DNS**, returning an internal IP for internal clients.
>
> `dig` by default also uses the system resolver, but it bypasses the OS resolver cache and the `nsswitch.conf` / `/etc/hosts` file. You can also force `dig` to query a specific DNS server directly:
> ```bash
> # Query Google's public DNS instead of your system DNS
> dig +short yourdomain.com @8.8.8.8
> ```
> This is useful because a WAF like Imperva uses **split-horizon DNS** — internal users and external users may resolve the same domain to different IPs. When testing for IP lockdown you want the **public-facing IP**, so always cross-check with a public DNS server like `8.8.8.8`.
>
> **What if `dig @8.8.8.8` still returns an Imperva IP?**
>
> This is actually a good sign — it means the domain's public DNS record points to Imperva, not directly to your origin. The WAF is correctly sitting in front. The CNAME (`*.impervadns.net`) and the resolved IP (`45.60.x.x`) both belong to Imperva's range.
>
> To find the **real origin IP** you need to look elsewhere:
> - Check your infrastructure (Azure portal, AWS console, app configuration)
> - Look at the WAF dashboard — Imperva shows the configured origin IP
> - Check internal DNS: `dig +short yourdomain.com @<your-internal-dns-server>`
> - Look at HTTP response headers for server banners or internal hostnames leaking through

### 2. Call the origin IP directly (not through the WAF)
```bash
# Replace ORIGIN_IP with the actual origin server IP
curl -v -H "Host: yourdomain.com" http://ed IP
/

# HTTPS
curl -v -k -H "Host: yourdomain.com" https://ORIGIN_IP/
```
The `-H "Host: ..."` header is needed so the origin server knows which virtual host to serve.

**Expected result after lockdown:** `Connection refused` or a timeout — the origin should not respond.  
**Bad result:** You get a `200 OK` response — the origin is still directly reachable.

### 3. Check which IP is actually serving the response
```bash
# Trace the route to see if requests go through the WAF IPs
curl -sv https://yourdomain.com 2>&1 | grep "Connected to"
```

### 4. Quick one-liner to test a list of Imperva ranges
```bash
# Verify your origin rejects requests NOT from Imperva
# (run from a machine outside the Imperva range)
curl -o /dev/null -s -w "%{http_code}" -H "Host: yourdomain.com" http://ORIGIN_IP/
# Should return 000 (connection refused/timeout), not 200
```

---

## How to request an origin IP review

Open a **Service Now Incident** to the queue `GIS_Cyber_Appsec` and include:
- The property / website name
- The origin IP to review
- The reason the review is required

