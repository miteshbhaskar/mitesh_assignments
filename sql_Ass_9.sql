drop database if exists sql_ass_9;
create database if not exists sql_ass_9;
use sql_ass_9;
select * from `sql_ass_9`.`cran_logs_2015-01-01`;

-- 9.1 give the total number of recordings in this table
select count(time) as recordings from `sql_ass_9`.`cran_logs_2015-01-01`; 

-- 9.2 the number of packages listed in this table?
select count(package) as packages from `sql_ass_9`.`cran_logs_2015-01-01`;

-- 9.3 How many times the package "Rcpp" was downloaded?
select package,count(package) as total_packages from `sql_ass_9`.`cran_logs_2015-01-01` where package='Rcpp';

-- 9.4 How many recordings are from China ("CN")?
select country,count(package) as packages from `sql_ass_9`.`cran_logs_2015-01-01` where country='CN';

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
select package,count(package) as download from `sql_ass_9`.`cran_logs_2015-01-01` group by package order by download desc;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
select package,count(package) as download,
case
	when count(package) <= 18 then 1
    when count(package) between 19 and 36 then 2
    when count(package) between 37 and 54 then 3
    when count(package) between 55 and 72 then 4
    when count(package) between 72 and 90 then 5
end as ranking 
 from `sql_ass_9`.`cran_logs_2015-01-01` where time between '09:00:00' and '11:00:00' group by package order by download desc;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
select country,count(package) as recordings from `sql_ass_9`.`cran_logs_2015-01-01` where country in ('CN','JP','SG') group by country;

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
select country,count(package) as download from `sql_ass_9`.`cran_logs_2015-01-01` group by country having download > 
(select count(package) from `sql_ass_9`.`cran_logs_2015-01-01` where country='CN');
 
-- 9.9 Print the average length of the package name of all the UNIQUE packages
select package ,avg(length(package)) as avg_length_package from `sql_ass_9`.`cran_logs_2015-01-01` group by package;

-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
select package,count(package) as download,
case
	when count(package) <= 200 then 1
    when count(package) between 201 and 400 then 2
    when count(package) between 401 and 600 then 3
    when count(package) between 601 and 700 then 4
    when count(package) between 801 and 1010 then 5
end as ranking 
 from `sql_ass_9`.`cran_logs_2015-01-01` group by package having ranking=2 order by download desc;

-- 9.11 Print the name of the package whose download count is bigger than 1000.
select package,count(package) as download from `sql_ass_9`.`cran_logs_2015-01-01` group by package having download > 1000;

-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
select r_os as op_system ,count(r_os) as relevent_count from `sql_ass_9`.`cran_logs_2015-01-01` group by r_os;

