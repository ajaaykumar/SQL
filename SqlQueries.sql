/*
Remove Redundant Pairs
For pairs of brands in the same year (e.g., apple/Samsung/2020 and Samsung/apple/2020):
	- If custom1 = custom3 and custom2 = custom4: then keep only one pair.
For pairs of brands in the same year
	- If custom1 != custom3 OR custom2 != custom4: then keep both pairs.
For brands that do not have pairs in the same year: keep those rows as well. 
*/

select * from abc.brands;

with cte as (
			select *, concat(brand1, brand2,year),
			case when brand1 < brand2 then concat(brand1, brand2, year) 
			else concat(brand2, brand1, year) 
			end brand_id
			from 
			abc.brands
			),
cte_id as (select *, row_number() over(partition by brand_id) brand_num from cte)
select brand1,brand2,"year",custom1,custom2,custom3,custom4 from cte_id where brand_num = 1 or (custom1 = custom3 and custom2 = custom4);









