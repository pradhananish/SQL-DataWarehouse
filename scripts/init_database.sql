/*

Create Database and Schemas

Script Purpose:
This script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
within the database: 'bronze', 'silver', and 'gold'.

WARNING:
Running this script will drop the entire 'DataWarehouse' database if it exists.
All data in the database will be permanently deleted. Proceed with caution


----------------------------------------
use master;
go

-- create database 
create database DataWarehouse;
go

--drop the data base if exist before

drop database if exists DataWarehouse;
go


use DataWarehouse;
go

--create schemas
create schema silver;
go

create schema bronze;
go

create schema gold;
go
