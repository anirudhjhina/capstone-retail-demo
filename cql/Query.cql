CREATE KEYSPACE TargetRetail WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': '3'
};


# Create a table brand with "name" as the partition key. 
	CREATE TABLE brand (
	  name text,
	  description text,
	  PRIMARY KEY (name))
  
# 	Create a table product with "product_id" as the partition key. 
#	The product_id is the partition key as the cashier will scan the product by product_id
#	Assumption: The product_id is the SKU. The reason for tracking a single product_id(SKU) is only viewing it from a retailer perspective. We are not concerned with tracking 
#				manufacturer's inventory.
		
	CREATE TABLE product (
	  product_id text,
	  titles text,
	  brand text,
	  price double,
	  PRIMARY KEY (product_id))
	  
	  

# 	Create a table stores with "store_id" as the partition key. This table holds all the information about the store.
#	The phone no are stored as maps as the store may have multiple phones e.g. per department.
#	Start time & End time of store are also stored as map as each day may have different time. This table can also accommodate if the store is closed on some national  holiday.
		  
	CREATE TABLE stores ( 
	  store_id text,
	  store_name text,
	  store_address text,
	  store_phone map<text,int>,
	  no_of_express_reg int,
	  no_of_full_reg int,
	  store_start_time map<text,timestamp>,
	  store_end_time map<text,timestamp>,
	  tax_rates float,
	  PRIMARY KEY (store_id));
	  
# 	Create a table employees with "employee_id" as the partition key. 
#	This table has store_id stored to track the employee in which store he works.
#	employee_dept can be a filed to track if the employee is a cashier or sales rep etc.	  
	CREATE TABLE employees ( 
	  employee_id text,
	  store_id text,
	  lastname_initial_id text,
	  first_name text,
	  last_name text,
	  employee_dept text,
	  PRIMARY KEY (employee_id));
	  
# 	Create a table register with "store_id" as the partition key and the register_id as the 	  
	CREATE TABLE register ( 
	  store_id text,
	  register_id text,
	  store_name text,
	  register_type text
	  PRIMARY KEY (store_id,register_id));
	  
	 
# 	Create a table receipts with "reciept_id" as the partition key and product_id as the clustering key.
# 	This table will hold line item data for the sale.
#	Store_id, payment_info, payment_details, total_reciept_price, register_id, employee_id, employee_name will be static as it will be same for all the rows in the partition.
	 
	 CREATE TABLE receipts ( 
	  receipt_id text,
	  product_id text,
	  title text,
	  sales_price float,
	  msrp float,
	  savings float,
	  quantity int,
	  store_id text STATIC,
	  payment_info text STATIC,
	  payment_details text STATIC,
	  total_reciept_price float STATIC,
	  register_id text STATIC,
	  employee_id text STATIC,
	  employee_name text STATIC,
	  scan_time timestamp STATIC,
	  PRIMARY KEY ((receipt_id) ,product_id ));
	  
	  

	  
	  
	  
	  
	  
	  
	  
	  