CREATE TABLE Silver.crm_cust_info(
cst_id INT ,
cst_key NVARCHAR(20),
cst_firstname NVARCHAR(30),
cst_lastname NVARCHAR(30),
cst_marital_status NVARCHAR(10),
cst_gndr NVARCHAR(10),
cst_create_date DATE,
create_date DATETIME DEFAULT GETDATE());
GO


CREATE TABLE Silver.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME,
create_date DATETIME DEFAULT GETDATE());
GO

CREATE TABLE Silver.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt DATE,
    sls_ship_dt  DATE,
    sls_due_dt   DATE,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT,
create_date DATETIME DEFAULT GETDATE());
GO

CREATE TABLE Silver.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50),
create_date DATETIME DEFAULT GETDATE());
GO

CREATE TABLE Silver.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50),
create_date DATETIME DEFAULT GETDATE());
GO


CREATE TABLE Silver.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50),
create_date DATETIME DEFAULT GETDATE());
GO
