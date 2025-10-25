BULK INSERT Bronze.crm_cust_info
FROM 'N:\SQL-COURSE\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK)

BULK INSERT Bronze.crm_prd_info
FROM 'N:\SQL-COURSE\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH(
FIRSTROW=2,
FIELDTERMINATOR=',',
TABLOCK)

BULK INSERT Bronze.crm_sales_details
		FROM 'N:\SQL-COURSE\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

BULK INSERT Bronze.erp_loc_a101
		FROM 'N:\SQL-COURSE\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

BULK INSERT Bronze.erp_cust_az12
		FROM 'N:\SQL-COURSE\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'N:\SQL-COURSE\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
