/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `COPY INTO  ` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    CALL bronze.load_bronze();
===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
    table_start_time TIMESTAMP;
    table_end_time TIMESTAMP;
BEGIN
    batch_start_time := CURRENT_TIMESTAMP;
    
    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer at: %', batch_start_time;
    RAISE NOTICE '================================================';

    -- CRM LOADING SECTION
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading CRM Tables...';
    RAISE NOTICE '------------------------------------------------';

    table_start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Truncating Table: crm_cust_info...';
    TRUNCATE TABLE bronze.crm_cust_info;
    RAISE NOTICE '>> Inserting Data Into Table: crm_cust_info...';
    COPY bronze.crm_cust_info FROM 'D:/datasets/source_crm/cust_info.csv' DELIMITER ',' CSV HEADER;
    table_end_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Load Duration: %', (table_end_time - table_start_time);
    RAISE NOTICE '------------------------------------------------';

    table_start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Truncating Table: crm_prd_info...';
    TRUNCATE TABLE bronze.crm_prd_info;
    RAISE NOTICE '>> Inserting Data Into Table: crm_prd_info...';
    COPY bronze.crm_prd_info FROM 'D:/datasets/source_crm/prd_info.csv' DELIMITER ',' CSV HEADER;
    table_end_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Load Duration: %', (table_end_time - table_start_time);
    RAISE NOTICE '------------------------------------------------';

    table_start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Truncating Table: crm_sales_detail...';
    TRUNCATE TABLE bronze.crm_sales_detail;
    RAISE NOTICE '>> Inserting Data Into Table: crm_sales_detail...';
    COPY bronze.crm_sales_detail FROM 'D:/datasets/source_crm/sales_details.csv' DELIMITER ',' CSV HEADER;
    table_end_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Load Duration: %', (table_end_time - table_start_time);

    -- ERP LOADING SECTION
    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading ERP Tables...';
    RAISE NOTICE '------------------------------------------------';

    table_start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Truncating Table: erp_cust_az12...';
    TRUNCATE TABLE bronze.erp_cust_az12;
    RAISE NOTICE '>> Inserting Data Into Table: erp_cust_az12...';
    COPY bronze.erp_cust_az12 FROM 'D:/datasets/source_erp/CUST_AZ12.csv' DELIMITER ',' CSV HEADER;
    table_end_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Load Duration: %', (table_end_time - table_start_time);
    RAISE NOTICE '------------------------------------------------';

    table_start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Truncating Table: erp_loc_a101...';
    TRUNCATE TABLE bronze.erp_loc_a101;
    RAISE NOTICE '>> Inserting Data Into Table: erp_loc_a101...';
    COPY bronze.erp_loc_a101 FROM 'D:/datasets/source_erp/LOC_A101.csv' DELIMITER ',' CSV HEADER;
    table_end_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Load Duration: %', (table_end_time - table_start_time);
    RAISE NOTICE '------------------------------------------------';

    table_start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Truncating Table: erp_px_cat_g1v2...';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    RAISE NOTICE '>> Inserting Data Into Table: erp_px_cat_g1v2...';
    COPY bronze.erp_px_cat_g1v2 FROM 'D:/datasets/source_erp/PX_CAT_G1V2.csv' DELIMITER ',' CSV HEADER;
    table_end_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Load Duration: %', (table_end_time - table_start_time);

    -- COMPLETION SUMMARY
    batch_end_time := CURRENT_TIMESTAMP;
    
    RAISE NOTICE '================================================';
    RAISE NOTICE 'BRONZE LAYER LOAD COMPLETED SUCCESSFULLY!';
    RAISE NOTICE 'Total Batch Execution Time: %', (batch_end_time - batch_start_time);
    RAISE NOTICE '================================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE WARNING '================================================';
        RAISE WARNING 'ERROR OCCURRED DURING LOADING BRONZE LAYER!';
        RAISE WARNING 'Error message: % - Details: %', SQLSTATE, SQLERRM;
        RAISE WARNING '================================================';
END;
$$;
