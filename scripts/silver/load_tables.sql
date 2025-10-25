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
ROW_NUMBER() OVER(PARTITION BY cst_id order by cst_create_date) as latest_record
FROM [Bronze].[crm_cust_info]
where cst_id is not null) t
where latest_record=1

--------checks----





