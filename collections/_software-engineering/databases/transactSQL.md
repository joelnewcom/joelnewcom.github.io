---
layout: single
---

## SELECT COUNT
SELECT COUNT(*) FROM <TableName> WITH (NOLOCK)

Explanation: On SQL Server the default transaction level is the READ COMMITTED. 
The table hint NOLOCK will ignore the locks on updating data. This might lead to a dirty read and phantom read (miss data or read it twice)

## WHERE IS NOT NULL
AND birthdate IS NOT NULL

## WHERE IS NULL
AND birthdate IS NULL

## WHERE LIKE
```
SELECT * FROM x WHERE LoginEmail LIKE 'startwith%'
SELECT * FROM x WHERE LoginEmail LIKE '%endwith'
SELECT * FROM x WHERE LoginEmail LIKE '%between%'
```

## LIMIT
-- Select the first 10 random employees.  
SELECT TOP(10)JobTitle, HireDate  
FROM HumanResources.Employee;  
GO  

# WHERE two dates are n days apart
```
SELECT [somedata]
, datediff(day, [createdon], [modifiedon])
FROM [dbo].[tablename]
WHERE datediff(day, [createdon], [modifiedon]) >= 30
```

# Delete

## Delete by multiple ids
```
DELETE FROM [egm].[EngagementUser] WHERE EngagementId IN (
'anId'
,'anotherId'
,'andanotherId'
)
```
