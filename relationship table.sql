select c.manuf_year,c.make,c.model,c.body,c.car_rate,c.transmission,count(vin),statename,
 e.engin_size,e.cylinders,e.feul_type,avg(e.feul_consump_city),
 avg(e.feul_consump_hwy),avg(e.feul_consump_combine),avg(e.co2_emission)
from car_sale as c
join emission as e on c.emission_id=e.emi_id
join state_records as s on c.state=s.statecode
group by manuf_year;

select * from car_sale where make='acura' and manuf_year=1997;


select make,state,manuf_year, selling_price from car_sale;
select manuf_year, make, avg(selling_price),
seller_name, count(vin)
from car_sale as c
join car_seller as cs on c.seller=cs.seller_name
group by manuf_year
order by manuf_year;


SELECT manuf_year, avg(co2_emission), avg(feul_consump_city), avg(feul_consump_hwy), avg(feul_consump_combine), c.make
from car_sale as c
join emission as e on c.make=e.make
group by manuf_year;


create view vsale.gdp_sale as 
select statename, 1997_gdp,1998_gdp,1999_gdp,2000_gdp,2001_gdp,2002_gdp,2003_gdp,2004_gdp,2005_gdp,2006_gdp,2007_gdp,2008_gdp,
2009_gdp,2010_gdp,2011_gdp,2012_gdp,2013_gdp, 2014_gdp, 2015_gdp, make, vin 
from state_records as sr 
join  state_gdp as sg on sr.GeoID=sg.GeoFIPS 
join car_sale as c on sr.statecode=c.state;
