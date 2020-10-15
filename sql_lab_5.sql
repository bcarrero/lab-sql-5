-- Instructions
USE sakila;
--    Drop column picture from staff.
DESCRIBE staff;
ALTER TABLE staff DROP picture;
-------------------------------
--    A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
-- We need to insert Tammy Sanders both as an employee and as a employee.
SELECT *
from customer
where first_name = 'Tammy' and last_name = 'Sanders';
-- Tammy is already a customer
-- We need to add her to the employee table
select * from staff;
-- since she is a customer already, we already have her address, so we need to select her address ID
-- => address_id = 79
-- => customer_id = 75
DESCRIBE staff;
INSERT into staff(username,first_name,last_name,addresS_id,email,store_id,active, password)
values ('potamo','Pep','Potamo', 79, 'tammy.sanders@sakilastaff.com',2,1,'');

---------------------------------
--    Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1 today.
SELECT *
from customer
where first_name = 'Charlotte'; 
-- Charlotte => customer_id = 130

SELECT * from film where title LIKE "Academy%";
-- => film_id = 1
SELECT * 
from inventory where film_id = 1;
select * 
from rental;
DESCRIBE rental;
INSERT into rental(rental_date,inventory_id,customer_id,staff_id)
values (current_date(),1,130,1
);
select * from rental order by rental_date DESC;
------------------------------------------------
--    Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date the user was deleted.
SELECT *
FROM customer WHERE active <> 1;
-- There are 
CREATE TABLE sakila.deleted_users
  AS (SELECT *, current_date() AS date_deleted
      FROM sakila.customer
      WHERE active <> 1);
DROP TABLE deleted_users;
SELECT * from deleted_users;
SELECT *, current_date() from deleted_users;

SELECT * from customer;
DELETE from sakila.customer WHERE active <> 1;
-- DELETE FROM db.table WHERE condition;
-- test adding date column
ALTER TABLE deleted_users
ADD date_deleted_1 datetime default now()
;
-- to be able to read csv files
show variables like 'local_infile';
set global local_infile = 1;

