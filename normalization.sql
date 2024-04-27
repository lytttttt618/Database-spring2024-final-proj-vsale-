-- Normaliaztion
-- ----------------------------------------------
-- for the state_gdp table, there is a composite primary keys, it is the 1NF
-- so we seperate this table, in order to get the 2NF
-- partial dependency: geofips->geoname,region
-- full dependency: geofips, linecode-> all other gdp attributes

update state_gdp
set region = 0 where GeoName = 'United States *';

create table vsale.geo_info(
 geofips varchar(45) not null,
 geoname varchar(45) not null,
 region varchar(45) not null);
 
insert into geo_info 
select GeoFIPs, GeoName, Region from state_gdp;

create table geo_reco like geo_info;
insert into geo_reco
select distinct * from geo_info;
drop table geo_info;

ALTER TABLE `vsale`.`geo_reco` 
ADD PRIMARY KEY (`geofips`);

alter table state_gdp
drop column GeoName,
drop column Region;
-- so we now have two new tables: geo_reco and state_gdp
-- --------------------------------------------------------

-- combine geographical information and the state information to safe space
insert into state_info 
values('United States *','us');

create table state_records(
GeoFIPs varchar(45) not null,
statename varchar(45) not null,
statecode varchar(5) not null,
region int not null);

INSERT INTO state_records(
select geofips, geoname, state_code, region from state_info as si
join geo_reco as gr on si.state_name = gr.geoname);

drop table state_info;
drop table geo_reco;

ALTER TABLE `vsale`.`state_records` 
ADD PRIMARY KEY (`GeoFIPs`);

-- then create the foreign key constrain, connect tables

ALTER TABLE `vsale`.`state_records` 
CHANGE COLUMN `GeoFIPs` `GeoID` VARCHAR(45) NOT NULL ;
-- connect gdp table and state information
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE `vsale`.`state_gdp` 
ADD CONSTRAINT `FK_geo_id`
  FOREIGN KEY (`GeoFIPs`)
  REFERENCES `vsale`.`state_records` (`GeoID`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

-- connect car_sale table with state records table using state_code as foreign key
alter table car_sale
modify state varchar(5) not null;

ALTER TABLE vsale.state_records
ADD UNIQUE INDEX statecode_UNIQUE (statecode ASC) VISIBLE;

ALTER TABLE vsale.car_sale 
ADD INDEX FK_state_idx (state ASC) VISIBLE;

ALTER TABLE `vsale`.car_sale 
ADD CONSTRAINT FK_state
  FOREIGN KEY (state)
  REFERENCES `vsale`.state_records (statecode)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

-- connect table seller and state records
ALTER TABLE `vsale`.car_seller
ADD INDEX `FK_seller_state_idx` (`seller_state` ASC) VISIBLE;
ALTER TABLE `vsale`.car_seller
ADD CONSTRAINT `FK_seller_state`
  FOREIGN KEY (`seller_state`)
  REFERENCES `vsale`.state_records (`statecode`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
  

-- seperate seller information, for future use, also save space
CREATE TABLE car_seller (
  seller_ID INT AUTO_INCREMENT PRIMARY KEY,
  seller_name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO car_seller (seller_name)
SELECT DISTINCT seller 
FROM `vsale`.car_sale;

UPDATE `vsale`.car_sale AS csa
INNER JOIN car_seller AS csr
ON csr.seller_name = csa.seller
SET csa.seller = csr.seller_ID;

alter table car_sale
modify seller int;


-- add foreign key constraint, connect table car_sale and car_seller
ALTER TABLE `vsale`.`car_sale` 
ADD INDEX `FK_seller_idx` (`seller` ASC) VISIBLE;
ALTER TABLE `vsale`.`car_sale` 
ADD CONSTRAINT `FK_seller`
  FOREIGN KEY (`seller`)
  REFERENCES `vsale`.`car_seller` (`seller_ID`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
ALTER TABLE `vsale`.`car_sale` 
CHANGE COLUMN `seller` `seller` INT NOT NULL ;


ALTER TABLE `vsale`.`car_seller` 
ADD COLUMN `seller_state` VARCHAR(5) NOT NULL AFTER `seller_name`;

UPDATE `vsale`.car_seller AS cs
INNER JOIN car_sale AS c
ON cs.seller_ID=c.seller
SET cs.seller_state=c.state;