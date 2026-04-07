---
layout: single
title: OSS License Overview
---

## Quick Reference: Risk Categories

| Risk | Meaning | Typical License Type |
|------|---------|----------------------|
| 🟢 Low Risk | Use freely in all scenarios | Permissive (MIT, Apache, BSD…) |
| 🟡 Medium Risk | Restrictions on modification/distribution | Weak Copyleft (LGPL, MPL, EPL…) |
| 🔴 High Risk | Strong obligations; avoid distribution | Strong Copyleft (GPL, AGPL…) |
| ⛔ Very High Risk | No use allowed | AGPL-3.0 |

---

## Permissive Licenses — 🟢 Low Risk

All use cases allowed: Internal Use, Outsourcing, Distribution (modified & unmodified), SaaS.

| License | SPDX | Key Obligation | GPL Compatible |
|---------|------|----------------|----------------|
| Academic Free License 2.1 | AFL-2.0 | Retain copyright & attribution notices | ❌ |
| Apache License 1.1 | Apache-1.1 | Retain copyright; no use of "Apache" name | ❌ |
| Apache License 2.0 | Apache-2.0 | Retain notices; include NOTICE file if present; mark modifications | ✅ (GPL-3 only) |
| Bouncy Castle License | — | Include copyright & permission notice | n/a |
| BSD 2-Clause | BSD-2-Clause | Retain copyright; reproduce in binary docs | ✅ |
| BSD 3-Clause | BSD-3-Clause | Retain copyright; no use of contributor names for advertising | ✅ |
| BSD 3-Clause Clear | BSD-3-Clause-Clear | Same as BSD-3; no patent rights granted | ✅ |
| BSD 4-Clause | BSD-4-Clause | Advertising acknowledgment required | ❌ |
| BSD (HSQL) | — | Retain copyright | ✅ |
| BSD Zero Clause | 0BSD | None | ✅ |
| CMU License | MIT-CMU | Include copyright + permission notice; no advertising | n/a |
| Creative Commons BY 3.0 | CC-BY-3.0 | Attribution to original author | n/a |
| Creative Commons BY 4.0 | CC-BY-4.0 | Attribution + notice of modifications | n/a |
| CC Public Domain (PDDC) | CC-PDDC | None | ✅ |
| Creative Commons Zero | CC0-1.0 | None (recommend including licence text) | ✅ |
| Eclipse Distribution License | — | Retain copyright; no use of Eclipse names for advertising | n/a |
| ICU License | ICU | Include copyright + permission notice | n/a |
| Indiana University Extreme! Lab | — | Retain copyright; acknowledgment in docs | n/a |
| ISC License | ISC | Include copyright + permission notice | ✅ |
| Java HTML Tidy | — | Copyright notice may not be removed | n/a |
| JavaUCL | — | Retain copyright; reproduce in binary docs | n/a |
| jQuery | MIT | See MIT License | ✅ |
| JSON License | JSON | Include copyright + permission notice | n/a |
| libpng License | Libpng | Copyright notice may not be removed | n/a |
| Microsoft Public License | MS-PL | Retain all notices | ❌ |
| MIT License | MIT | Include copyright + licence text | ✅ |
| MIT No Attribution | MIT-0 | None | ✅ |
| OpenSSL License | OpenSSL | Retain copyright; acknowledgment in docs | ❌ |
| PostgreSQL License | PostgreSQL | Include copyright paragraph | ✅ |
| Python Software Foundation 2.0 | PSF-2.0 | Retain PSF copyright notice | n/a |
| SIL Open Font License | OFL-1.0 | Include copyright + licence | ✅ |
| The Universal FOSS Exception | — | None | n/a |
| The Unlicense | Unlicense | None | ✅ |
| W3C Software Notice and License | W3C | Include full NOTICE text | ✅ |
| zlib License | Zlib | Notice may not be removed from source | ✅ |

---

## Weak Copyleft Licenses — 🟡 Medium Risk

Allowed: Internal Use, Outsourcing, Distribution of **unmodified** OSS, SaaS of **unmodified** OSS.  
⚠️ Distribution or SaaS use of **modified** versions requires careful review.

| License | SPDX | Copyleft Scope | GPL Compatible | Key Obligations |
|---------|------|---------------|----------------|-----------------|
| Artistic License 2.0 | Artistic-2.0 | Modifications | ✅ | Duplicate copyright notices |
| CeCILL 1.0 | CECILL-1.0 | Modified software | ✅ (via §5.3.4) | Copy of agreement; limitation notices |
| CDDL 1.0 | CDDL-1.0 | Modified files in existing OSS files | ❌ | Licence notice; source code disclosure for modifications; contributor ID |
| CDDL 1.1 | CDDL-1.1 | Same as CDDL-1.0 | ❌ | See CDDL-1.0 |
| Common Public License 1.0 | CPL-1.0 | Modifications | ❌ | Retain copyright; identify contributor |
| EPL 1.0 | EPL-1.0 | Modifications | ❌ | Retain copyright |
| EPL 2.0 | EPL-2.0 | Modifications | ❌ | Licence text; copyright notices; source disclosure; contributor ID |
| GPL-2.0 with Classpath Exception | GPL-2.0-CE | Linking exception for independent modules | ✅ | Licence notice; source disclosure if modified |
| IBM Public License 1.0 | IPL-1.0 | Modifications | ❌ | Include IBM copyright notice |
| LGPL 2.0 | LGPL-2.0 | Library modifications | ✅ (GPL v1/v2) | Licence text; source disclosure; copyright notices |
| LGPL 2.1 | LGPL-2.1 | Library modifications | ✅ (GPL v2/v3) | Licence text; source/modification disclosure; copyright; no extra restrictions |
| LGPL 3.0 | LGPL-3.0 | Library modifications | ✅ (GPL v3) | GPL-3 + LGPL-3 texts; prominent notice; installation info for consumer devices |
| Mozilla Public License 1.0 | MPL-1.0 | Modified OSS files | n/a | Licence notice; source disclosure; Exhibit A duplication |
| Mozilla Public License 1.1 | MPL-1.1 | Modified OSS files | Partial (§13) | Licence notice; source disclosure; Exhibit A; modification description |
| Mozilla Public License 2.0 | MPL-2.0 | Modified OSS files | ✅ (via §3.3) | Licence notice; source disclosure; no alteration of licence notices |
| CC BY-SA 2.0 | CC-BY-SA-2.0 | Derivative works | n/a | Attribution to original author |
| CC BY-SA 3.0 | CC-BY-SA-3.0 | Derivative works | n/a | Full attribution; credit in adaptations |
| CC BY-SA 4.0 | CC-BY-SA-4.0 | Derivative works | ✅ → GPL-3 (one-way) | Attribution; notice of modifications; licence reference |

---

## Strong Copyleft Licenses — 🔴 High Risk

Allowed: Internal Use, Outsourcing only.  
⚠️ SaaS use of modified **and** unmodified versions requires detailed review. Distribution triggers source code disclosure obligations.

| License | SPDX | Notes |
|---------|------|-------|
| GPL 1.0 | GPL-1.0 | Strong copyleft; compatible with itself only |
| GPL 2.0 | GPL-2.0 | Static/dynamic linking may trigger source disclosure of proprietary code |
| GPL 3.0 | GPL-3.0 | Allows object code with download notice; installation info required for consumer devices |

---

## Very High Risk — ⛔ No Use Allowed

| License | SPDX | Reason |
|---------|------|--------|
| GNU AGPL 3.0 | AGPL-3.0 | Copyleft triggered **also by SaaS use** (network use = distribution). Must be removed unless contractual relationship with supplier exists. |

---

## Proprietary Licenses — 🔴 High / Medium Risk

These are **not OSS**. Use restricted to Internal Use and Outsourcing. Distribution and SaaS use subject to specific terms.

| License | Risk | Notes |
|---------|------|-------|
| Aspose EULA | High | — |
| International Program License Agreement | High | — |
| Microsoft ASP.NET MVC 4 Extensions | High | — |
| Microsoft Chart Controls for .NET 3.5 | High | Display valid copyright notice on programs |
| Microsoft Expression Blend SDK for .NET 4.0 | High | Wrongly classified; free .NET libraries |
| Microsoft .NET Library | High | Wrongly classified; free .NET libraries |
| Microsoft HPC Pack 2019 | High | — |
| Microsoft Production Performance SDK | High | Only pre-release licence terms available |
| Oracle Free Use Terms and Conditions | Medium | Unmodified use ok; modifications restricted |
| Oracle Technology Network (APEX) | Medium | No removal of markings/notices |
| Oracle Technology Network License | Medium | No removal of markings/notices |
| ServiceStack License Agreement | High | — |
| SQL Server Shared Management Objects | Medium | Display valid copyright notice |

---

## Common Obligations Summary

When **distributing** software that includes OSS, typical obligations are:

1. **Include licence text** — deliver a copy of the licence with the software
2. **Retain copyright notices** — do not remove or alter existing notices
3. **Mark modifications** — clearly state what was changed and when
4. **Source code disclosure** — required for copyleft licences when distributing modified code
5. **No endorsement** — do not use the author's name to promote derived products (BSD-3, Apache…)
6. **Attribution** — credit original authors (CC-BY, Apache NOTICE file…)

---

## GPL Compatibility — Why It Matters and What "Incompatible" Actually Means

### Why do licences even interfere with each other?

When you **combine** two pieces of software into one binary or one deployed application — by linking, bundling, or importing — the resulting combined work legally falls under **both** licences simultaneously. If both licences allow this, they are *compatible*. If one licence says "you may only distribute this code under my terms, and my terms alone", it creates a conflict that makes combining legally impossible.

The classic example: GPL-2.0 says *"any work you distribute that contains GPL code must be distributed under GPL-2.0 in its entirety"*. Apache 2.0 says *"you must include our patent termination clause"*. GPL-2.0 forbids adding any such extra clause. **Neither licence can fully satisfy the other → incompatible.**

In practice this means:
- You **cannot ship** a compiled `.jar` or binary that contains both GPL-2.0 and Apache-2.0 code without violating one of the licences
- You **cannot merge** source files from two incompatible licences into one codebase you distribute
- For **internal use only** it is largely irrelevant — the conflict only triggers on distribution or (with AGPL) network use

### Why GPL-2 and GPL-3 are the reference point

GPL is used as the **measuring stick** because:

1. **It is the most restrictive widely-used copyleft licence** — if your licence is GPL-compatible, it is almost certainly compatible with everything else too
2. **GPL-licensed code is everywhere** — the Linux kernel (GPL-2), Git (GPL-2), GCC (GPL-3), countless libraries. You will encounter it
3. **The FSF (Free Software Foundation) maintains an official compatibility list** — the industry adopted this as the standard reference, so "GPL compatible" is a universally understood signal
4. GPL-2 and GPL-3 are listed separately because they are **not compatible with each other** in both directions — this is a famous and painful real-world problem (Linux kernel cannot adopt GPL-3 dependencies)

A complete N×N matrix for all ~500 OSS licences would be enormous and mostly irrelevant. In practice, the licences you encounter in enterprise Java/JS/Python land are a small subset, and GPL compatibility covers ~90% of the real-world conflicts you will face.

### GPL-2 vs GPL-3 — the compatibility gap

| Situation | GPL-2 | GPL-3 |
|-----------|-------|-------|
| Can use GPL-3 code | ❌ | ✅ |
| Can use GPL-2 code | ✅ | ✅ (if "or later" clause present) |
| Apache 2.0 compatible | ❌ | ✅ |
| LGPL-3.0 compatible | ❌ | ✅ |
| Tivoization clause | None | Forbids hardware lockdown |

GPL-3 added protections against hardware manufacturers locking down GPL software (the "Tivoization" clause). This is why Linus Torvalds refused to move the Linux kernel to GPL-3 — it would break embedded hardware vendors. So GPL-2 and GPL-3 coexist as two incompatible standards.

### Why Linux is permanently stuck on GPL-2

This is not just a preference — it is a **legal deadlock** with no realistic way out.

**The "or later" clause is the key mechanism.** Most GPL projects are licensed as *"GPL-2.0 or later"*, meaning any recipient can choose to use the code under GPL-2 or any later GPL version. This gives the FSF a migration path: when GPL-3 came out, most projects could simply relicense by choosing "or later". The Linux kernel was licensed as **"GPL-2.0 only"** — no "or later". Linus did this deliberately.

**Why Linus chose GPL-2 only:**  
The Tivoization clause in GPL-3 (Section 6) requires that if you ship GPL software on a device, the user must be able to install modified versions of that software on the device. TiVo (the DVR company) shipped Linux on their hardware but cryptographically signed the firmware so users couldn't replace it. FSF considered this a violation of the spirit of the GPL. GPL-3 explicitly forbids it.

Linus disagreed. His position: *"I want hardware vendors to be able to use Linux without having to open up their entire device."* Embedded vendors, phone manufacturers, router makers — they all depend on being able to lock down firmware while still using Linux. GPL-3 would make Linux unusable for them, which would fragment the ecosystem or push vendors to alternative kernels.

**The deadlock — why it can never be changed:**  
To relicense the Linux kernel from GPL-2-only to GPL-2-or-later (or GPL-3), you would need **written permission from every single contributor who ever submitted accepted code** to the kernel. The kernel has had **tens of thousands of contributors** over 30+ years. Many are:
- Dead
- Unreachable
- Companies that no longer exist
- Developers who contributed as employees where the copyright belongs to a company that was acquired or dissolved

Getting unanimous consent is **practically impossible**. Even if 99.9% agreed, the remaining 0.1% is enough to block it legally. Some contributors have explicitly stated they will never agree to GPL-3.

**The real-world consequence:**  
This means you **cannot legally combine** Linux kernel code with any GPL-3-only licensed code in a distributed product. It also means the Linux kernel will never benefit from GPL-3's patent protection clauses or anti-Tivoization rules — which is exactly what Linus wanted.

### Compatibility Reference Table

| Licence | + GPL-2 | + GPL-3 | + Apache-2.0 | + MIT | Notes |
|---------|---------|---------|--------------|-------|-------|
| MIT | ✅ | ✅ | ✅ | — | No restrictions; absorbs into anything |
| Apache 2.0 | ❌ | ✅ | — | ✅ | Patent clause conflicts with GPL-2 |
| BSD-2/3 | ✅ | ✅ | ✅ | ✅ | Permissive; no conflicts |
| LGPL-2.1 | ✅ | ✅ | ✅ | ✅ | Weak copyleft; linking exception saves it |
| LGPL-3.0 | ❌ | ✅ | ✅ | ✅ | Built on GPL-3; inherits GPL-2 incompatibility |
| EPL-1.0/2.0 | ❌ | ❌ | ❌ | ✅ | Choice-of-law clause conflicts with GPL |
| MPL-2.0 | ✅ (§3.3) | ✅ | ✅ | ✅ | File-level copyleft; §3.3 explicitly enables GPL combination |
| AGPL-3.0 | ❌ | Partial | ❌ | ✅ | SaaS copyleft; only combine if whole result is AGPL |
| CDDL-1.0 | ❌ | ❌ | ❌ | ✅ | Governing law clause; cannot combine with GPL |
| CC0 | ✅ | ✅ | ✅ | ✅ | Public domain; no restrictions |

### Practical rule of thumb

> If your application is **internal only** → compatibility is irrelevant, you are not distributing.  
> If you **ship to customers or run external SaaS** → you must ensure no incompatible licences are combined in your distributed artefact.  
> The most common real-world trap: accidentally pulling in a **GPL-2.0** transitive dependency into a Spring (Apache 2.0) application you distribute. Your CI licence check catches this before it becomes a legal problem.

---

## The NOTICE File — What It Is and Why It Exists

The `NOTICE` file requirement comes from **Apache License 2.0**. It's a standardized, human-readable attribution file that must travel with the software — even in compiled/binary form.

**Why it exists:** Large collaborative projects (Spring, Kafka, Hadoop…) have dozens of contributing organizations that all need to be credited. A copyright header in source files isn't enough. The NOTICE file is the formal place for that.

**Your obligation:** If an Apache-licensed library you use ships a `NOTICE` file, you must include its contents when you distribute your product — including as a SaaS deployment to external users.

In practice:
- Small GitHub projects → rarely bother, low enforcement risk
- Major Apache projects (Spring, Tomcat, Maven) → always ship one, you inherit the obligation
- Internal tools only → largely theoretical
- **Shipping to customers or external SaaS → real legal risk if ignored**

---

## How to Handle This Automatically

Don't do this manually. Use a tool that scans your dependencies and generates a combined NOTICE/attribution file as part of your build.

### Maven — `license-maven-plugin`

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>license-maven-plugin</artifactId>
  <version>2.4.0</version>
  <executions>
    <execution>
      <id>aggregate-add-third-party</id>
      <goals><goal>aggregate-add-third-party</goal></goals>
    </execution>
  </executions>
</plugin>
```

Generates a `THIRD-PARTY.txt` with all dependency licences. Run with:

```bash
mvn license:aggregate-add-third-party
```

---

## Integrate It into CI/CD

The real value is **blocking the build** when a forbidden licence sneaks in (e.g. AGPL-3.0, GPL-2.0 in a distributed product).

**Example: GitHub Actions with `license-checker` (npm)**

```yaml
- name: Check licences
  run: |
    npx license-checker --production \
      --failOn "GPL-2.0;GPL-3.0;AGPL-3.0" \
      --excludePrivatePackages
```

**Example: Maven in pipeline**

```yaml
- name: Check licences
  run: mvn license:aggregate-add-third-party license:check
```

Fail the pipeline on any High/Very High risk licence → no surprises in audits.

---