CREATE TABLE test (id INT, value INT);

INSERT INTO test(id,value)  VALUES(1,150);
INSERT INTO test(id,value)  VALUES(2,10);
INSERT INTO test(id,value)  VALUES(3,80);
INSERT INTO test(id,value)  VALUES(4,20);
INSERT INTO test(id,value)  VALUES(5,40);

SELECT id, value,  SUM(value) OVER (ORDER BY id ASC) AS new_value
FROM test;

--http://sqlfiddle.com/#!17/7b3ae/1