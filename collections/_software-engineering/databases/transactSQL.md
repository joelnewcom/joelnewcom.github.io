---
layout: single
---

# SELECT

## By comma separated values

```
DECLARE @CommaSeparatedValues NVARCHAR(MAX) = '1,2,3,4,5,6';

DECLARE @ValuesToCheck TABLE (Value NVARCHAR(50));
INSERT INTO @ValuesToCheck (Value)
SELECT LTRIM(STR(CAST(TRIM(value) AS INT)))
FROM STRING_SPLIT(@CommaSeparatedValues, ',');

SELECT *
FROM [schema].[tableName]
WHERE [number] IN (
    SELECT Value
    FROM @ValuesToCheck
);
```

## SELECT COUNT
SELECT COUNT(*) FROM <TableName> WITH (NOLOCK)

Explanation: On SQL Server the default transaction level is the READ COMMITTED. 
The table hint NOLOCK will ignore the locks on updating data. This might lead to a dirty read and phantom read (miss data or read it twice)

## COUNT GROUP BY
SELECT column_name, COUNT(column_name)
FROM table_name
GROUP BY column_name;

## COUNT GROUP BY, only show where count > 1
```
SELECT COUNT(*) as Count, [column_name]
FROM [table_name]
GROUP BY [column_name]
HAVING COUNT(*) > 1
```

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
SELECT [somedata], datediff(day, [createdon], [modifiedon])
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

# Update
## Update single column
```
  UPDATE [dbo].[tableName]
  SET columName = 'value'
  FROM [dbo].[tableName] WHERE IdColumnName = 'value'
```