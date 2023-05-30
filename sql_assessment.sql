use cats;
drop table country;
create table country(
id int not null primary key auto_increment,
country_name varchar(50),
country_name_eng varchar(50),
country_code char (3)
);

create table city (
id int not null primary key auto_increment,
city_name varchar (50),
lat float8,
long_ float8,
country_id int,
foreign key (country_id) references country(id)
);

create table customer(
id int not null primary key auto_increment,
customer_name varchar(50),
city_id int,
customer_address varchar(50),
next_call_date date,
ts_inserted datetime,
foreign key (city_id) references city(id)
);

insert into country (country_name,country_name_eng,country_code) values
('Deutschland','Germany','DEU'),
('Srbija','Serbia','SRB'),
('Hrvatska','Crotia','HRV'),
('United States of America','United States of America','USA'),
('Polska','Poland','POL'),
('Espana','Spain','ESP'),
('Rossiya','Russia','RUS');


insert into city (city_name,lat,long_,country_id) values
('Berlin',52.520008,13.404954,1),
('Belgrade',44.787197,20.457273,2),
('Zagreb',45.815399,15.966568,3),
('New York',40.730610,-73.935242,4),
('Los Angeles',34.052235,-118.243683,4),
('Warsaw',52.237049,21.017532,5);

insert into customer (customer_name,city_id,customer_address,next_call_date,ts_inserted) values
('Jewley Store',4,'Long street 120','2020-01-21','2020-01-09 14:01:20.000'),
('Bakery',1,'Kurfurstendamm 25','2020-02-21','2020-01-09 17:52:15.000'),
('Cafe',1,'Tauentzienstrabie 44','2020-01-21','2020-01-10 08:02:49.000'),
('Restaurant',3,'Ulica lipa 15','2020-01-21','2020-01-10 09:20:21.000');
select * from city,country;


-- que.1
select country_name_eng,city_name,customer_name from country 
left join city on country.id=city.country_id left join customer on customer.city_id=city.id;

-- que.2
select country_name_eng from country left join city on country.id=city.country_id left join customer on customer.city_id=city.id where customer_name is null;

