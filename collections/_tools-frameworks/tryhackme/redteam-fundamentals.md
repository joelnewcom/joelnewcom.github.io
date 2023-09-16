---
layout: single
---

# Red team engagement

A red team engagement shall test the blue team capabilities. The engagement does not only look for vulnerabilities like
Pentesting, but simulates an actual attack.

* Try to hide, keep low profile
* Do lateral movements
* Real hack into machines
* Blue team is not informed about it
* Usage of social engineering and even physical penetration tactics
* Red team might emulate an existing APT group like APT38 by using the TTPs (Technics, Tactics and Procedures) of this
  particular group.

# Cyber kill chain (Lockheed Martin)

| Technique 	           | Purpose                                                                           | 	Examples                                        |
|-----------------------|-----------------------------------------------------------------------------------|--------------------------------------------------| 
| Reconnaissance        | Obtain information on the target                                                  | Harvesting emails, OSINT                         |
| Weaponization         | Combine the objective with an exploit. Commonly results in a deliverable payload. | Exploit with backdoor, malicious office document |
| Delivery              | How will the weaponized function be delivered to the target 	                     | Email, web, USB                                  |
| Exploitation          | Exploit the target's system to execute code                                       | MS17-010, Zero-Logon, etc.                       |
| Installation          | Install malware or other tooling                                                  | Mimikatz, Rubeus, etc.                           |
| Command & Control     | Control the compromised asset from a remote central controller                    | Empire, Cobalt Strike, etc.                      |
| Actions on Objectives | Any end objectives: ransomware, data exfiltration, etc.                           | Conti, LockBit2.0, etc.                          |


