## SELECT COUNT
SELECT COUNT(*) FROM <TableName> WITH (NOLOCK)

Explanation: On SQL Server the default transaction level is the READ COMMITTED. 
The table hint NOLOCK will ignore the locks on updating data. This might lead to a dirty read and phantom read (miss data or read it twice)

## WHERE IS NOT NULL
AND birthdate IS NOT NULL

## WHERE IS NULL
AND birthdate IS NULL

## LIMIT
-- Select the first 10 random employees.  
SELECT TOP(10)JobTitle, HireDate  
FROM HumanResources.Employee;  
GO  