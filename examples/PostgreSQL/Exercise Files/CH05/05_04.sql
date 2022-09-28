CREATE TABLE customer_summary  
	(id serial primary key,  
	customer_doc jsonb);

insert into customer_summary (customer_doc) values 
	('{"customer_name" : {"first_name":"Alice", 
						"last_name":"Johnson"},
		"address": {"street": "5432 Port Ave", 
					"city":"Boston", 
					"state_province":"MA", 
					"postal_code":"02101"},
		"purchase_history_summary": {"annual_purhase_value":[100.00, 200.00, 350.00], 
									 "lifetime_value": 1500.00
									 }
		}');

select * from customer_summary;

select customer_doc from customer_summary;

select customer_doc->'customer_name' from customer_summary;

select customer_doc->'customer_name'->>'first_name' from customer_summary;

