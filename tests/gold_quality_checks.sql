*******************************************************************
---Checking 'gold.dim_customers
******************************************************************
select
    customer_key,
    count(*) as duplicate_count
from gold.dim_customers
group by customer_key
having count(*) > 1;


*******************************************************************
---Checking 'gold.dim_products
******************************************************************
select distinct
	ci.cst_gndr,
	ca.gen,
	case when ci.cst_gndr ! = 'n/a' then ci.cst_gndr 
	else coalesce (ca.gen, 'n/a')
	end as new_gen
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid

order by 1,2

*******************************************************************
---Checking 'gold.fact_sales
******************************************************************
select * from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key 
left join gold.dim_products p
on p.produc_key = f.produc_key
where p.produc_key is null
