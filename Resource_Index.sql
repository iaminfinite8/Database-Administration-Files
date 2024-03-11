SHOW INDEXES From customer;
show table status from infinity;


ALTER TABLE store ENGINE=INNODB;
optimize table payment;
analyze table rental;


select table_schema, table_name, data_free, engine 
from information_schema.tables where table_schema 
not in ('information_schema', 'mysql') and data_free > 0;


select customer_id,first_name,last_name , email from customer ;

select customer_id,first_name,last_name , email from customer where last_name= 'TRAVIS';

ALTER TABLE `infinity`.`customer` 
DROP INDEX `idx_last_name` ;
;

ALTER TABLE `infinity`.`customer` 
ADD INDEX `idx_last_name` (`last_name` ASC) VISIBLE;



select distinct(store_id) from customer;

CREATE TABLE IF NOT EXISTS contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    UNIQUE KEY unique_email (email)
);

INSERT INTO contacts(first_name,last_name,phone,email)
VALUES('Zane','Doe','(408)-444-9795','zane.doe@swiftalchemy.com');


select * from contacts;

INSERT INTO contacts(first_name,last_name,phone,email)
VALUES('kaylor','swift','(408)-999-4421','john.doe@swiftalchemy.com');


CREATE TABLE t (
    a INT,
    b INT,
    INDEX a_asc_b_asc (a ASC , b ASC),
    INDEX a_asc_b_desc (a ASC , b DESC),
    INDEX a_desc_b_asc (a DESC , b ASC),
    INDEX a_desc_b_desc (a DESC , b DESC)
);

/*
 DELIMITER $$
CREATE PROCEDURE `insertSampleData`(
IN rowCount INT, 
    IN low INT, 
    IN high INT)
BEGIN
 DECLARE counter INT DEFAULT 0;
    REPEAT
        SET counter := counter + 1;
        -- insert data
        INSERT INTO t(a,b)
        VALUES(
            ROUND((RAND() * (high-low))+high),
            ROUND((RAND() * (high-low))+high)
        );
    UNTIL counter >= rowCount
    END REPEAT;
END$$
DELIMITER ;
 */

CALL insertSampleData(10000,1,1000);


select count(1) from t;

EXPLAIN SELECT * FROM   t ORDER BY a , b; -- use index 

EXPLAIN SELECT * FROM t ORDER BY a , b DESC; -- use index a_asc_b_desc

EXPLAIN SELECT * FROM t ORDER BY a DESC , b; -- use index a_desc_b_asc

EXPLAIN SELECT * FROM t ORDER BY a DESC , b DESC; -- use index a_desc_b_desc
