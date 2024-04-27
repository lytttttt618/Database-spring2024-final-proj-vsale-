use vsale;
DELETE FROM car_sale
WHERE make ='';

alter table car_sale
add column emission_id int null;


UPDATE car_sale AS cs
INNER JOIN emission AS em ON cs.make = em.make
SET cs.emission_id= em.emi_id;

alter table emission
modify make varchar(45) not null;

ALTER TABLE `vsale`.`car_sale` 
DROP INDEX `FK_emission_id_idx` ;
;
ALTER TABLE `vsale`.`car_sale` 
ADD CONSTRAINT `FK_emission_connect`
  FOREIGN KEY (`emission_id`)
  REFERENCES `vsale`.`emission` (`emi_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

-- use index