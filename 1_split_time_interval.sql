CREATE TABLE time (start_time TIMESTAMP, end_time TIMESTAMP);

INSERT INTO time VALUES('2020-03-02 13:02:00', '2020-03-02 15:55:07');

SELECT CASE WHEN c = 1 THEN start_time ELSE DATE_TRUNC('hour',start_time) + INTERVAL '30' minute *  (c-1) END AS start_time, 
       CASE WHEN end_time < DATE_TRUNC('minute',start_time + INTERVAL '30' minute *  c)
            THEN end_time ELSE DATE_TRUNC('hour',start_time) + INTERVAL '30' minute * c END AS end_time
  FROM time
 CROSS JOIN unnest (ARRAY[1,2,3,4,5,6]) AS c;

-- http://sqlfiddle.com/#!17/1903b/18