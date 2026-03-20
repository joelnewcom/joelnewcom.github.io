---
layout: single
title: "[Day 18] Sigma Lumberjack Lenny Learns New Rules"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Sigma
Sigma is a yaml query language which is used to create queries for SIEM system. 
The Simga query can be transformed in various languages like elastic Query with the python library pySigma. 
Also Undercoder.io can convert Sigma queries.

# Task
You become an attack chain report with indicators of compromise (IOCs)
![IOC](/assets/images/tryhackme/day18/IOCs.PNG)
 

Sigma query template
```
title:
id: # UUID
status: # experimental, test, stable, deprecated, unsupported.
description:
author:
date:
modified:

logsource: # Outlines target source of the logs based on operating system, service being run, category of logs.
  product: # windows, linux, macos.
  service: # sshd for Linux, Security for Windows, applocker, sysmon.
  category: # firewall, web, antivirus, process_creation, network_connection, file_access.
detection:
  selection:
    {FieldName1: Value} # Change me

  condition: selection # Action to be taken. Can use condition operators such as OR, AND, NOT when using multiple search identifiers.

falsepositives: # Legitimate services or use.

level:  # informational, low, medium, high or critical.

tags: # Associated TTPs from MITRE ATT&CK
  - {attack.tactic} # MITRE Tactic
  - {attack.technique} # MITRE Technique 
``` 

## Account creation
```
title: Account creation
id: 0f06a3a5-6a09-413f-8743-0f06a3a54567
status: experimental
description: Detext the creation of local user account on a computer
author: say_what_again
date: 2023-01-05
modified: 2023-01-05

logsource: # Outlines target source of the logs based on operating system, service being run, category of logs.
 product: windows
 service: security
 category: # firewall, web, antivirus, process_creation, network_connection, file_access.
detection:
 selection:
   EventID:
    - 4720 # Change me

 condition: selection # Action to be taken. Can use condition operators such as OR, AND, NOT when using multiple search identifiers.

falsepositives: # Legitimate services or use.
 - unknown
level:  low

tags: # Associated TTPs from MITRE ATT&CK
 - attack.persistence # MITRE Tactic
 - attack.T1136.001 # MITRE Technique c
```

## Software discovery

```
title: Software discovery
id: # UUID
status: experimental # experimental, test, stable, deprecated, unsupported.
description: Process creation
author: say_what_again
date:
modified:

logsource: # Outlines target source of the logs based on operating system, service being run, category of logs.
  product: windows # windows, linux, macos.
  service: sysmon # sshd for Linux, Security for Windows, applocker, sysmon.
  category: # firewall, web, antivirus, process_creation, network_connection, file_access.
detection:
  selection:
    EventID:
     - 1 # Change me
    Image|endswith:
     - '\reg.exe'
    CommandLine|contains|all:
     - '/v'
     - 'svcVersion'
  condition: selection # Action to be taken. Can use condition operators such as OR, AND, NOT when using multiple search identifiers.

falsepositives: # Legitimate services or use.
 - unknown

level: low # informational, low, medium, high or critical.

tags: # Associated TTPs from MITRE ATT&CK
  - attack.discovery # MITRE Tactic
  - attack.T1518.001 # MITRE Technique 
```
## Execution
```
title: Process Creation
id: # UUID
status: # experimental, test, stable, deprecated, unsupported.
description:
author:
date:
modified:

logsource: # Outlines target source of the logs based on operating system, service being run, category of logs.
  product: windows # windows, linux, macos.
  service: sysmon # sshd for Linux, Security for Windows, applocker, sysmon.
  category: # firewall, web, antivirus, process_creation, network_connection, file_access.
detection:
  selection:
    EventID:
     - 1
    Image|endswith:
     - 'schtasks.exe'
    ParentImage|endswith:
     - 'cmd.exe'
    CommandLine|contains|all:
     - '/create'

  condition: selection # Action to be taken. Can use condition operators such as OR, AND, NOT when using multiple search identifiers.

falsepositives: # Legitimate services or use.
 - unknown

level:  low # informational, low, medium, high or critical.

tags: # Associated TTPs from MITRE ATT&CK
  - attack.execution} # MITRE Tactic
  - attack. T1053.005 # MITRE Technique 
```