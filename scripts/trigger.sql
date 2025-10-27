CREATE TABLE customer_logs(
customer_id int,
log_message varchar(50),
logdate date)




create trigger customer_log on [Silver].[crm_cust_info]
after insert as
begin 
insert into customer_logs(customer_id,log_message,logdate)
select 
cst_id,
'new employee added',
GETDATE()
from inserted
end


insert into [Silver].[crm_cust_info] ([cst_id]
           ,[cst_key]
           ,[cst_firstname]
           ,[cst_lastname]
           ,[cst_marital_status]
           ,[cst_gndr]
           ,[cst_create_date])
values(29484,'AW00029484','Rishi','Naath','Single','Male','2026-01-27')

select * from [Silver].[crm_cust_info] where cst_id=29484

select * from customer_logs
