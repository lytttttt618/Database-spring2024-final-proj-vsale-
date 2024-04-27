
update car_sale
set c_condition=0
where c_condition='';
alter table car_sale
modify c_condition int null;
-- stratify the car condition level

alter table car_sale
add column car_rate varchar(10) not null;

update car_sale
set car_rate='fair'
where c_condition>-1 and c_condition<17;
update car_sale
set car_rate='good'
where c_condition>16 and c_condition<33;
update car_sale
set car_rate='excellent'
where c_condition>32 and c_condition<50;

alter table car_sale
drop column c_condition;