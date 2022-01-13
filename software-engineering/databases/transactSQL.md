## SELECT
SELECT COUNT(*) FROM <TableName> WITH (NOLOCK)

Explanation: On SQL Server the default transaction level is the READ COMMITTED. 
The table hint NOLOCK will ignore the locks on updating data. This might lead to a dirty read and phantom read (miss data or read it twice) 