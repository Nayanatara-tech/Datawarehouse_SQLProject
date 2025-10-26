---------Checks------
select 
cst_id,
count(*) FROM [Bronze].[crm_cust_info]
GROUP BY cst_id
having count(*)>1 or cst_id is null

select * from [Bronze].[crm_cust_info] where cst_id=29449

SELECT DISTINCT(cst_gndr) from [Bronze].[crm_cust_info]
SELECT DISTINCT(cst_marital_status) from [Bronze].[crm_cust_info]

---loading-----------
INSERT INTO silver.crm_cust_info
(cst_id, 
			cst_key, 
			cst_firstname, 
			cst_lastname, 
			cst_marital_status, 
			cst_gndr,
			cst_create_date)
SELECT 
cst_id, 
			cst_key, 
			cst_firstname, 
			cst_lastname, 
			cst_marital_status, 
			cst_gndr,
			cst_create_date
FROM (
SELECT cst_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE WHEN UPPER(trim(cst_marital_status))='M' THEN 'Married'
     WHEN UPPER(trim(cst_marital_status))='S' THEN 'Single'
     ELSE 'n/a'
END AS cst_marital_status,
CASE WHEN UPPER(trim(cst_gndr))='M' THEN 'Male'
     WHEN UPPER(trim(cst_gndr))='F' THEN 'Female'
     ELSE 'n/a'
END AS cst_gndr,
cst_create_date,
ROW_NUMBER() OVER(PARTITION BY cst_id order by cst_create_date DESC) as latest_record
FROM [Bronze].[crm_cust_info]
where cst_id is not null) t
where latest_record=1

SELECT * FROM [Silver].[crm_prd_info]
ALTER TABLE [Silver].[crm_prd_info]
ADD cat_id VARCHAR(50)

-----------------------Checks-----------------
SELECT prd_id,
count(*)
from [Bronze].[crm_prd_info]
group by prd_id
having count(*)>1

select * from [Bronze].[erp_px_cat_g1v2]

------------------Loading---------------------
INSERT INTO Silver.crm_prd_info (
			prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt
		)
SELECT
prd_id,
replace(substring(prd_key,1,5),'-','_') as cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
prd_nm,
isnull(prd_cost,0) as prd_cost,
CASE 
				WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
				WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
				WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
				WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
				ELSE 'n/a'
			END AS prd_line,
cast(prd_start_dt as date) as prd_start_dt,
CAST(
				LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 
				AS DATE
			) AS prd_end_dt
from [Bronze].[crm_prd_info]

---------------------------------------
SELECT * FROM [Bronze].[crm_sales_details]

------------------------Loading----------------------------
INSERT INTO Silver.crm_sales_details (
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,
			sls_price
		)
		SELECT 
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE 
				WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
			END AS sls_order_dt,
			CASE 
				WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
			END AS sls_ship_dt,
			CASE 
				WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
			END AS sls_due_dt,
			CASE 
				WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
					THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales
			END AS sls_sales, 
			sls_quantity,
			CASE 
				WHEN sls_price IS NULL OR sls_price <= 0 
					THEN sls_sales / NULLIF(sls_quantity, 0)
				ELSE sls_price  
			END AS sls_price
		FROM Bronze.crm_sales_details;

SELECT * FROM Silver.crm_sales_details

---------------LOADING---------------
INSERT INTO Silver.erp_cust_az12 (
			cid,
			bdate,
			gen
		)
		SELECT
			CASE
				WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid)) 
				ELSE cid
			END AS cid, 
			CASE
				WHEN bdate > GETDATE() THEN NULL
				ELSE bdate
			END AS bdate, 
			CASE
				WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
				WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
				ELSE 'n/a'
			END AS gen
		FROM Bronze.erp_cust_az12;

----------------Loading----------------
INSERT INTO Silver.erp_loc_a101 (
			cid,
			cntry
		)
		SELECT
			REPLACE(cid, '-', '') AS cid, 
			CASE
				WHEN TRIM(cntry) = 'DE' THEN 'Germany'
				WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
				WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
				ELSE TRIM(cntry)
			END AS cntry 
		FROM Bronze.erp_loc_a101;

----------------Loading------------------
INSERT INTO Silver.erp_px_cat_g1v2 (
			id,
			cat,
			subcat,
			maintenance
		)
		SELECT
			id,
			cat,
			subcat,
			maintenance
		FROM Bronze.erp_px_cat_g1v2;




