-- Restore Encrypted Database on another Server
-- ON Source DB server run the below query

-- Step 1
-- To check if any databases are encrypted

SELECT
db.name,
db.is_encrypted,
dm.encryption_state,
dm.percent_complete,
dm.key_algorithm,
dm.key_length,
db.database_id
FROM
sys.databases db
LEFT OUTER JOIN sys.dm_database_encryption_keys dm
ON db.database_id = dm.database_id;
GO

-- Step 2
-- Take a Full Backup to move on to another server

-- Step 3
-- Check the Certificates on Master DB

SELECT * FROM sys.certificates;

-- Step 4
-- Backup the Certificate with Encryption key, this to be run on Master DB

BACKUP CERTIFICATE MyServerCert
TO FILE = 'C:\Temp\SQLBackup\TDE_Cert'
WITH PRIVATE KEY (file='C:\Temp\SQLBackup\TDE_CertKey.pvk',
ENCRYPTION BY PASSWORD='mycertificatepassword@1234')