USE vsale;
SELECT manuf_year, seller_name, seller_state, make
from car_sale as cs
join car_seller as csr on cs.seller = csr.seller_ID
group by manuf_year, seller
order by manuf_year;

-- add an index to make in the car_sale table, speed up the execution time of the above query from 3.687 to 3.656
ALTER TABLE car_sale 
ADD INDEX make_idx(make);


-- add an index to the seller name column in the car_seller table
-- after adding the index, execution time greatly shrink
select seller_name,statename,region from car_seller as c 
join state_records as sr
on c.seller_state=sr.statecode;

ALTER TABLE car_seller
ADD INDEX SName_idx(seller_name);

