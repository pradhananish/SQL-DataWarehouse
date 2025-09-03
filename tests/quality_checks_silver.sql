Checking 'silver.crm_cust_info'
******************************************************
  
---Check the id is repeated or not
select cst_id ,count(*) from silver.crm_cust_info
group by cst_id 
having count(*)>1 or cst_id is null

---Check fcor unwanted space
select cst_key
from silver.crm_cust_info
where cst_key != trim(cst_key) 

---Data standardization and consistency
select distinct cst_gndr
from silver.crm_cust_info

  
Checking 'silver.crm_prd_info'
******************************************************
  
---Check the id is repeated or not
select prd_id ,count(*) from silver.crm_prd_info
group by prd_id 
having count(*)>1 or prd_id is null
  
---Check the unwanted space
select prd_nm
from bronze.crm_prd_info
where prd_nm != trim(prd_nm)
  
---Check for cost which is null or 0
select prd_cost
from bronze.crm_prd_info
where prd_cost < 0 or prd_cost is null
  
---Data standardization and consistency
select distinct prd_line 
from bronze.crm_prd_info

---Check for invalid data order (start date > end date)
select * 
from silver.crm_prd_info
where prd_end_dt < prd_start_dt


Checking 'silver.crm_sales_details'
******************************************************
  
---Checke for invalid date 
select 
nullif(sls_order_dt, 0) as sls_order_dt
from bronze.crm_sales_details
where sls_order_dt <=0 
    or len(sls_order_dt)  !=8 
    or sls_order_dt>20500101
    or sls_order_dt < 19000101

---Check for invalid dates:
select *
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt
   or sls_order_dt > sls_due_dt;

---Check for data consistency in sales values:
select distinct
    sls_sales,
    sls_quantity,
    sls_price
from silver.crm_sales_details
where sls_sales != sls_quantity * sls_price
   or sls_sales is null
   or sls_quantity is null
   or sls_price is null
   or sls_sales <= 0
   or sls_quantity <= 0
   or sls_price <= 0
order by sls_sales, sls_quantity, sls_price;


Checking 'silver.erp_cust_az12'
******************************************************
  
---Identify out-of-range birthdates
select distinct
    bdate
from silver.erp_cust_az12
where bdate < '1924-01-01'
   or bdate > getdate();


---check standardized gender values
select distinct
    gen
from silver.erp_cust_az12
order by gen;

Checking 'silver.erp_loc_a101'
******************************************************
  
---Data Standardization & Consistency Checks
---Check standardized country values
select distinct
    centry
from silver.erp_loc_a101
order by centry;


Checking 'silver.erp_loc_a101'
******************************************************
  
---Check for unwanted spaces in category tables
select *
from silver.erp_px_cat_g1v2
where cat != trim(cat)
   or subcat != trim(subcat)
   or maintenance != trim(maintenance);

---Check distinct values of 'maintenance'
select distinct
    maintenance
from silver.erp_px_cat_g1v2
order by maintenance;
