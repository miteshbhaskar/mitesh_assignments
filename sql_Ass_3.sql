drop database if exists sql_ass_3;
create database if not exists sql_ass_3;
use sql_ass_3;

CREATE TABLE Warehouses (
   Code INTEGER NOT NULL,
   Location VARCHAR(255) NOT NULL ,
   Capacity INTEGER NOT NULL,
   PRIMARY KEY (Code)
 );
CREATE TABLE Boxes (
    Code CHAR(4) NOT NULL,
    Contents VARCHAR(255) NOT NULL ,
    Value REAL NOT NULL ,
    Warehouse INTEGER NOT NULL,
    PRIMARY KEY (Code),
    FOREIGN KEY (Warehouse) REFERENCES Warehouses(Code)
 ) ENGINE=INNODB;
 
  INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);
 
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);
select * from warehouses;
select * from boxes;
 
 -- 3.1 Select all warehouses.
select * from warehouses;

-- 3.2 Select all boxes with a value larger than $150.
select * from boxes where value>150;

-- 3.3 Select all distinct contents in all the boxes.
select distinct Contents from boxes;

-- 3.4 Select the average value of all the boxes.
select avg(value) from boxes;

-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
select warehouse,avg(value) as avg_value_boxes from boxes group by Warehouse;

-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
select warehouse,avg(value) as avg_value_boxes from boxes group by Warehouse having avg_value_boxes >150;

-- 3.7 Select the code of each box, along with the name of the city the box is located in.
select boxes.code,warehouses.Location from boxes join warehouses on boxes.Warehouse=warehouses.Code;

-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
select warehouses.code as warehouse, ifnull(count(boxes.code),0) as boxes from boxes left join warehouses on boxes.Warehouse=warehouses.Code group by Warehouse;
select * from boxes,warehouses; 

-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
 select warehouse, count(boxes.code) as boxes_c,Capacity from boxes 
left join warehouses on boxes.Warehouse=warehouses.Code  group by Warehouse having  count(boxes.code) > Capacity ;

-- 3.10 Select the codes of all the boxes located in Chicago.
select boxes.code,location as box from boxes left join warehouses on boxes.Warehouse=warehouses.Code where warehouses.Location='chicago';

-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
insert into warehouses (code,location,capacity) values (6,'New York',3);
select * from warehouses;

-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
insert into boxes (code,contents,value,warehouse) values("H5RT","Papers",200,2);
select * from boxes;

-- 3.13 Reduce the value of all boxes by 15%.
select value as ori_value,value-(value*15/100) as reduced_values from boxes;

-- 3.14 Remove all boxes with a value lower than $100.
delete from boxes where value<100; 
select * from boxes;

-- 3.15 Remove all boxes from saturated warehouses.
delete from boxes
where warehouse in
(SELECT Code
 FROM Warehouses
 WHERE Capacity < ( SELECT COUNT(*) FROM Boxes WHERE Warehouse = Warehouses.Code) );

-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
CREATE INDEX INDEX_WAREHOUSE ON Boxes (warehouse);
select * from boxes;

-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
SHOW INDEX FROM Boxes FROM sql_ass_3;
SHOW INDEX FROM sql_ass_3.Boxes;

-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
    
    
    
    
    