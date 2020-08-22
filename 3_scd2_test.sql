CREATE TABLE dim_customer 
(id INT, 
 current_version_flag INT, 
 date_from DATE, 
 date_to DATE, 
 name VARCHAR(50)
);

INSERT INTO dim_customer VALUES(1,0,'2020-01-01','2020-01-31','Dave');
INSERT INTO dim_customer VALUES(1,0,'2020-02-01','2020-02-29','Dave Ng');
INSERT INTO dim_customer VALUES(1,0,'2020-03-01','2020-04-30','Dave New');
INSERT INTO dim_customer VALUES(1,0,'2020-04-01','2020-05-31','Dave New2');
INSERT INTO dim_customer VALUES(1,1,'2020-06-01','2020-07-01','Dave Latest');
INSERT INTO dim_customer VALUES(2,1,'2020-06-01','2020-07-01','John');
                      
                   
--Test duplicates

SELECT id, COUNT(1) 
FROM dim_customer 
WHERE current_version_flag = 1
GROUP BY 1 HAVING COUNT(1) > 1;                