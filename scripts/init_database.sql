/*
========================================
Create Database and Schemas
========================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


USE master;
GO

-- Drop and recreate the 'datawarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarhouse') 
BEGIN 
	ALTER DATABASE DataWarhouse SET SINGLE_USER WITH ROLLBACK IMMEDIIATE;
	DROP DATABASE DataWarhouse;
END;
GO

-- Creating 'datawarehouse' database:
CREATE DATABASE DataWarhouse;

-- Switch to Database:
USE DataWarhouse;

-- Create Schema (For Bronze, Silver, Gold layer):
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO



