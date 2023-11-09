-- Step 5
-- Copy the relevant 3 Backup files (Backup file, Certificate file, PrivateKey file)


-- Step 6
-- Try to Restore it will be failed due to unable to find the certificate 

-- Step 7
-- Create Master key on the Target server

USE master;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'dontaskmeagain@1234';
GO

-- Step 8
-- Create a Certificate from the Source Server Backup
USE master;
GO
CREATE CERTIFICATE BackupEncryptionCert
FROM FILE = 'C:\Temp\SQLBackup\TDE_Cert'
WITH PRIVATE KEY (FILE = N'C:\Temp\SQLBackup\TDE_CertKey.pvk', DECRYPTION BY PASSWORD = 'mycertificatepassword@1234');
GO

-- Step 10
-- To check if any databases are encrypted & end result should be 3 for encryption

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