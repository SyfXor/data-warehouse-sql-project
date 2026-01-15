/*
------------------------------------------------------------------------------------------------------
Bronze Layer Load Procedure (Source to Bronze)
------------------------------------------------------------------------------------------------------
This is a load procedure script. It loads data from external csv files into bronze schema. It first 
truncates the existing tables in the schema and then load the data into the tables.

Example Usage:
----> CALL bronze.load_bronze()
------------------------------------------------------------------------------------------------------
*/

-- Drop if exists first
DROP PROCEDURE IF EXISTS bronze.load_bronze();
-- Create Procedure
CREATE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    rows_inserted BIGINT;
	start_time TIMESTAMP;
	end_time TIMESTAMP;
	duration DOUBLE PRECISION;
	batch_start_time TIMESTAMP;
	batch_end_time TIMESTAMP;
	batch_duration DOUBLE PRECISION;
BEGIN
	batch_start_time := clock_timestamp();
	RAISE NOTICE '======================================================';
	RAISE NOTICE 'Loading Bronze Layer...';
	RAISE NOTICE '======================================================';

	RAISE NOTICE '------------------------------------------------------';
	RAISE NOTICE 'Loading CRM Tables';
	RAISE NOTICE '------------------------------------------------------';

	start_time := clock_timestamp();
	RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;
	RAISE NOTICE '>> Inserting Data into: bronze.crm_cust_info';
	COPY bronze.crm_cust_info
	FROM 'D:\Personal\projects\data-warehouse-sql-project\datasets\source_crm\cust_info.csv'
		DELIMITER ','
		CSV HEADER;
	SELECT COUNT(*) INTO rows_inserted
    FROM bronze.crm_cust_info;
	RAISE NOTICE '>> Rows inserted: %', rows_inserted;
	end_time := clock_timestamp();
	duration := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '-- Load Duration (sec) %', duration;

	start_time := clock_timestamp();
	RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;
	RAISE NOTICE '>> Inserting Data into: bronze.crm_prd_info';
	COPY bronze.crm_prd_info
	FROM 'D:\Personal\projects\data-warehouse-sql-project\datasets\source_crm\prd_info.csv'
		DELIMITER ','
		CSV HEADER;
	SELECT COUNT(*) INTO rows_inserted
    FROM bronze.crm_prd_info;
    RAISE NOTICE '>> Rows inserted: %', rows_inserted;
	end_time := clock_timestamp();
	duration := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '-- Load Duration (sec) %', duration;
		
	start_time := clock_timestamp();
	RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;
	RAISE NOTICE '>> Inserting Data into: bronze.crm_sales_details';
	COPY bronze.crm_sales_details
	FROM 'D:\Personal\projects\data-warehouse-sql-project\datasets\source_crm\sales_details.csv'
		DELIMITER ','
		CSV HEADER;
	SELECT COUNT(*) INTO rows_inserted
    FROM bronze.crm_sales_details;
    RAISE NOTICE '>> Rows inserted: %', rows_inserted;
	end_time := clock_timestamp();
	duration := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '-- Load Duration (sec) %', duration;

	RAISE NOTICE '------------------------------------------------------';
	RAISE NOTICE 'Loading ERP Tables';
	RAISE NOTICE '------------------------------------------------------';

	start_time := clock_timestamp();
	RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
	RAISE NOTICE '>> Inserting Data into: bronze.erp_cust_az12';
	COPY bronze.erp_cust_az12
	FROM 'D:\Personal\projects\data-warehouse-sql-project\datasets\source_erp\CUST_AZ12.csv'
		DELIMITER ','
		CSV HEADER;
	SELECT COUNT(*) INTO rows_inserted
    FROM bronze.erp_cust_az12;
    RAISE NOTICE '>> Rows inserted: %', rows_inserted;
	end_time := clock_timestamp();
	duration := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '-- Load Duration (sec) %', duration;

	start_time := clock_timestamp();
	RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
	RAISE NOTICE '>> Inserting Data into: bronze.erp_loc_a101';
	COPY bronze.erp_loc_a101
	FROM 'D:\Personal\projects\data-warehouse-sql-project\datasets\source_erp\LOC_A101.csv'
		DELIMITER ','
		CSV HEADER;
	SELECT COUNT(*) INTO rows_inserted
    FROM bronze.erp_loc_a101;
    RAISE NOTICE '>> Rows inserted: %', rows_inserted;
	end_time := clock_timestamp();
	duration := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '-- Load Duration (sec) %', duration;
		
	start_time := clock_timestamp();
	RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	RAISE NOTICE '>> Inserting Data into: bronze.erp_px_cat_g1v2';
	COPY bronze.erp_px_cat_g1v2
	FROM 'D:\Personal\projects\data-warehouse-sql-project\datasets\source_erp\PX_CAT_G1V2.csv'
		DELIMITER ','
		CSV HEADER;
	SELECT COUNT(*) INTO rows_inserted
    FROM bronze.erp_px_cat_g1v2;
    RAISE NOTICE '>> Rows inserted: %', rows_inserted;
	end_time := clock_timestamp();
	duration := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '-- Load Duration (sec) %', duration;

	batch_end_time := clock_timestamp();
	batch_duration := EXTRACT(EPOCH FROM (batch_end_time - batch_start_time));
	RAISE NOTICE '======================================================';
	RAISE NOTICE 'Loading Bronze Layer is Completed';
	RAISE NOTICE '-- Total Load Duration (sec) %', batch_duration;
	RAISE NOTICE '======================================================';
	
EXCEPTION
    WHEN OTHERS THEN
        RAISE WARNING '** ETL failed: %', SQLERRM;
END;
$$;
