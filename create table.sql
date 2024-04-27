CREATE DATABASE vsale;
USE vsale;
-- -----------------------------------------------------
-- Table state_gdp
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vsale.State_GDP (
  GeoFIPs VARCHAR(45) NULL,
  GeoName VARCHAR(45) NULL,
  Region varchar(45) NULL,
  TableName VARCHAR(45) NULL,
  Linecode INT NULL,
  unit varchar(55) NULL,
  1997_gdp FLOAT NULL,
  1998_gdp FLOAT NULL,
  1999_gdp FLOAT NULL,
  2000_gdp FLOAT NULL,
  2001_gdp FLOAT NULL,
  2002_gdp FLOAT NULL,
  2003_gdp FLOAT NULL,
  2004_gdp FLOAT NULL,
  2005_gdp FLOAT NULL,
  2006_gdp FLOAT NULL,
  2007_gdp FLOAT NULL,
  2008_gdp FLOAT NULL,
  2009_gdp FLOAT NULL,
  2010_gdp FLOAT NULL,
  2011_gdp FLOAT NULL,
  2012_gdp FLOAT NULL,
  2013_gdp FLOAT NULL,
  2014_gdp FLOAT NULL,
  2015_gdp FLOAT NULL,
  2016_gdp FLOAT NULL,
  2017_gdp FLOAT NULL,
  2018_gdp FLOAT NULL,
  2019_gdp FLOAT NULL,
  2020_gdp VARCHAR(45) NULL);
  
  -- IMPORT DATA into gdp table
  
LOAD DATA INFILE 'USGDP_ALL_AREAS_1997_2020.csv' INTO TABLE State_GDP
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT * FROM State_GDP
WHERE GeoFIPs IS NULL OR Linecode IS NULL;


-- -----------------------------------------------------
-- Table car sale
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vsale.car_sale (
  manuf_year int null,
  make varchar(45) NULL,
  model varchar(45) NULL,
  trim varchar(255) null,
  body varchar(45) null,
  transmission varchar(45) null,
  vin varchar(255) null,
  state varchar(45) null,
  c_condition varchar(100) null,
  odometer float null,
  ext_color varchar(45) null,
  int_color varchar(45) null,
  seller varchar(255) null,
  mmr float null,
  selling_price float null,
  saledate varchar(255) null);
  
    -- IMPORT DATA into car sale table
  
LOAD DATA INFILE 'car_prices.csv' INTO TABLE car_sale
FIELDS TERMINATED BY ','
IGNORE 1 LINES;
  


-- -----------------------------------------------------
-- Table CO2 EMISSION
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vsale.emission(
  make varchar(255) null,
  model varchar(255) null,
  vehicle_class varchar(255) null,
  engin_size float null,
  cylinders int null,
  transmission varchar(45) null,
  feul_type char(1) null,
  feul_consump_city float null,
  feul_consump_hwy float null,
  feul_consump_combine float null,
  feul_consump_combine_mpg float null,
  co2_emission int null
);

LOAD DATA INFILE 'CO2 Emissions.csv' INTO TABLE emission
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


-- create state info table
-- -----------------------------------------------------
 create table state_info(
  state_name varchar(45) not null,
  state_code varchar(5) not null);
  

LOAD DATA INFILE 'state.csv' INTO TABLE state_info
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

