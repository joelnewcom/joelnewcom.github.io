---
layout: single
---

# Fresh installation
To work with MS SQL database locally, the easiest way is to run SQL Server 2019 Express or SQL Server 2019 Developer edition locally.
The installation requires admin access and the user used to install the server will be the database server admin.

Once installed you can connect to the database with SQL server management studio via the admin credential used to install the sql server.
![provide access to other user](/assets/images/software-engineering/databases/sql-server-management-studio-connect.PNG)


# Provide access rights to other users
Then click on "Security" -> "Logins" -> "BUILTIN\Users" (In German: "Vordefiniert\Users") 
![provide access to other user](/assets/images/software-engineering/databases/ssql-server-management-studio.PNG)

and provide needed access to all windows logins. This is obviously only for developing purposes.
![provide access to other user](/assets/images/software-engineering/databases/sql-server-management-studio-grant-access.PNG)

When you enable the sysadmin flag, every Windows user becomes admin on the sql server.

# Am I sysadmin?
To check if your current account has admin priviledge run: 
```
SELECT name,type_desc,is_disabled, create_date
FROM master.sys.server_principals
WHERE IS_SRVROLEMEMBER ('sysadmin',name) = 1
ORDER BY name
```

Or use more sophisticated query:
```
USE master
GO
SELECT DISTINCT p.name AS [loginname] ,
p.type ,
p.type_desc ,
p.is_disabled,
s.sysadmin,
CONVERT(VARCHAR(10),p.create_date ,101) AS [created],
CONVERT(VARCHAR(10),p.modify_date , 101) AS [update]
FROM sys.server_principals p
JOIN sys.syslogins s ON p.sid = s.sid
JOIN sys.server_permissions sp ON p.principal_id = sp.grantee_principal_id
WHERE p.type_desc IN ('SQL_LOGIN', 'WINDOWS_LOGIN', 'WINDOWS_GROUP')
/**— Logins that are not process logins **/
AND p.name NOT LIKE '##%'
/** Logins that are sysadmins or have GRANT CONTROL SERVER **/
AND (s.sysadmin = 1 OR sp.permission_name = 'CONTROL SERVER')
ORDER BY p.name
GO
```

Thats how it looks like when you have sys-admin access:
![You are admin](/assets/images/software-engineering/databases/sql-server-management-studio-check-access-admin.PNG)

Thats how it looks like if you don't have sys-admin access:
![You are admin](/assets/images/software-engineering/databases/sql-server-management-studio-check-access-admin-no.PNG)

# Export data as CSV
To export a small set of data: 
Run a SQL statement with ```Results to Grid``` output. Then right-click on the grid and select ```Save Results As...``` and then you can choose between tab or semicolon delimited.

# History table (Temporal)
SQL tables can be configured to keep every change. 

````
CREATE TABLE mySchema.User
(
    Id               UNIQUEIDENTIFIER default (newid()),
    CONSTRAINT PK_Id PRIMARY KEY (Id),
    -- For temporal table
    ValidFrom        DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo          DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = mySchema.UserHistory));


modelBuilder.Entity<User>(entity =>
{
    entity
        .ToTable("User", "mySchema")
        .ToTable(tb => tb.IsTemporal(ttb =>
            {
                ttb.UseHistoryTable("UserHistory", "mySchema");
                ttb
                    .HasPeriodStart("ValidFrom")
                    .HasColumnName("ValidFrom");
                ttb
                    .HasPeriodEnd("ValidTo")
                    .HasColumnName("ValidTo");
            }));
````

## Delete Table

````
ALTER TABLE mySchema.User SET ( SYSTEM_VERSIONING = OFF )
GO

DROP TABLE mySchema.User
GO

````