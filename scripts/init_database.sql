/*
-----------------------------------------------
Create Database and Schemas
-----------------------------------------------
Script Purpose:
This script creates a new database named "DataWarehouse" after checking if there exists same named database. If exists then, 
the script will drop the database and recreate it again. Also, this script create three schemas in the database named: silver, bronze and gold.

WARNING:
Running this script will drop database named "DataWarehouse" with all of its data if exists. So, proper backups should be taken before running the script.
*/

-- Create Database 'DataWarehouse'
DROP DATABASE IF EXISTS DataWarehouse;
CREATE DATABASE DataWarehouse;

-- Connect manually to the database 
-- Cretae Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
