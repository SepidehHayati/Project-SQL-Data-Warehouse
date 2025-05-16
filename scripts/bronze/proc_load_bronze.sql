/*
=====================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=====================================================================

Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Uses the BULK INSERT command to load data from CSV files to bronze tables.

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;

=====================================================================
*/



EXEC bronze.load_bronze;
GO
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '======================================================';
		PRINT 'lOADING BRONZE LAYER';
		PRINT '======================================================';

		PRINT '------------------------------------------------------';
		PRINT 'lOADING CRM TABLES';
		PRINT '------------------------------------------------------';

		--- For all Tables, first we TRUNCATE (make the table empthy) and then INSERT the rows once.

		--- 1. For 'bronze.crm_cust_info' table:
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT 'INSERTING DATA INTO TABLE: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\spdhy\Desktop\Prtfolio\dwh_project\SQL\datasets\source_crm\cust_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION IS:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'SECOND';
		PRINT '>> ************';

		--- 2. For 'bronze.crm_prd_info' table:
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE Table: bronze.crm_prd_info';
		PRINT 'INSERTING DATA INTO TABLE: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\spdhy\Desktop\Prtfolio\dwh_project\SQL\datasets\source_crm\prd_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION IS:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'SECOND';
		PRINT '>> ************';

		--- 3. For 'bronze.crm_prd_info' table:
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE Table: bronze.crm_sales_details';
		PRINT 'INSERTING DATA INTO TABLE: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\spdhy\Desktop\Prtfolio\dwh_project\SQL\datasets\source_crm\sales_details.csv'
		WITH 
		(
			FIRSTRoW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION IS:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'SECOND';
		PRINT '>> ************';

		PRINT '------------------------------------------------------';
		PRINT 'lOADING ERP TABLES';
		PRINT '------------------------------------------------------';


		--- 4. For 'bronze.erp_cust_az12' table:
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT 'INSERTING DATA INTO TABLE: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\spdhy\Desktop\Prtfolio\dwh_project\SQL\datasets\source_erp\CUST_AZ12.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION IS:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'SECOND';
		PRINT '>> ************';


		--- 5. For 'bronze.erp_loc_a101' table:
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE Table: bronze.erp_loc_a101';
		PRINT 'INSERTING DATA INTO TABLE: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\spdhy\Desktop\Prtfolio\dwh_project\SQL\datasets\source_erp\LOC_A101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION IS:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'SECOND';
		PRINT '>> ************';


		--- 6. For 'bronze.erp_px_cat_g1v2' table:
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT 'INSERTING DATA INTO TABLE: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\spdhy\Desktop\Prtfolio\dwh_project\SQL\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION IS:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'SECOND';
		PRINT '>> ************';

		SET @batch_end_time = GETDATE();
		PRINT '===================================================';
		PRINT '>> LOADING BRONZE LAYER IS COMPLETED.';
		PRINT '>> TOTAL DURATION:' + cast (DATEDIFF(SECOND, @batch_start_time, @batch_end_time ) AS NVARCHAR) + 'SECOND';
		PRINT '===================================================';


	END TRY
	BEGIN CATCH
		PRINT '===================================================';
		PRINT 'ERROR ACCURED DURING LOADING BRONZE LAYER!';
		PRINT '===================================================';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();

	END CATCH
END
GO
