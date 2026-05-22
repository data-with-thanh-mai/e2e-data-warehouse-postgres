/*
=============================================
Create Database and Schemas
=============================================
Scripts Purpose:
	This scripts creates a new database named "DataWarehouse" after checking if it already exits.
	If the database exists, it is dropped and recreated.  
WARNING: 
	Running the scripts will drop the entire 'DataWarehouse' database if it exists.
	All the data in the database will be permanently deleted. Proceed with caution and
	ensure you have proper backups before running this script.
	
EXECUTION INSTRUCTIONS:
    Due to PostgreSQL transaction rules, you cannot run this entire file at once.
    Please HIGHLIGHT (select) and EXECUTE each block individually in this order:
        Step 1: Highlight and run the block to terminate active connections.
        Step 2: Highlight and run the block to drop/create the database.
        Step 3: Switch your connection to the new "DataWarehouse" database.
		Step 4: Highlight and run the block to create schemas.
*/

-- Terminate all other active connections
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'DataWarehouse' AND pid <> pg_backend_pid();

-- Drop database 
DROP DATABASE IF EXISTS "DataWarehouse";

-- Create database 
CREATE DATABASE "DataWarehouse";

-- Create schemas 
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
