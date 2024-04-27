-- drop gdp data after 2105 & Add primary key for table State_GDP
ALTER TABLE `vsale`.`state_gdp` 
DROP COLUMN `2020_gdp`;

  ALTER TABLE `vsale`.`state_gdp` 
DROP COLUMN `2019_gdp`,
DROP COLUMN `2018_gdp`,
DROP COLUMN `2017_gdp`,
DROP COLUMN `2016_gdp`;

ALTER TABLE `vsale`.`state_gdp` 
CHANGE COLUMN `GeoFIPs` `GeoFIPs` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `Linecode` `Linecode` INT NOT NULL ,
ADD PRIMARY KEY (`GeoFIPs`, `Linecode`);

-- drop useless attribute
ALTER TABLE `vsale`.`state_gdp` 
DROP COLUMN `TableName`;
ALTER TABLE `vsale`.`state_gdp` 
DROP COLUMN `unit`;

  -- clean data and set primary key for table car sale
use vsale;
select * from car_sale;

delete from car_sale where vin='';
delete from car_sale where manuf_year <1997;

update vsale.car_sale
set saledate= STR_TO_DATE(saledate, '%a %b %d %Y');
alter table car_sale modify saledate DATE;

ALTER TABLE `vsale`.`car_sale` 
CHANGE COLUMN `vin` `vin` VARCHAR(255) NOT NULL ,
ADD PRIMARY KEY (`vin`);


ALTER TABLE `vsale`.`emission` 
ADD COLUMN `emi_id` INT NOT NULL AUTO_INCREMENT AFTER `co2_emission`,
ADD PRIMARY KEY (`emi_id`);

ALTER TABLE `vsale`.`state_info` 
ADD PRIMARY KEY (`state_name`);


update state_info
set state_code = lower(state_code);
 