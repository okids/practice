/*
- Cross project query is not possible in Redshift (even cross project different databases is not possible), while accessing MySQL / PostgreSQL in AWS is possible using federated queries
- Cross project query with different region is not possible in BQ, however cross project query within same region is possible

Example of cross project query within same region in BQ

*/

CREATE TABLE IF NOT EXISTS test.newtable AS SELECT 19 AS century, 1900 AS year_start, 1999 AS year_end UNION ALL SELECT 20, 2000, 2999;


CREATE TABLE IF NOT EXISTS test.newtable_crossproject
AS
SELECT is_male, century, COUNT(*) cnt from publicdata.samples.natality r 
CROSS JOIN test.newtable y
WHERE r.year >= y.year_start AND r.year <= y.year_end
GROUP BY 1,2;

SELECT * FROM test.newtable_crossproject;

-- Cross project query within same region but different database (external databases)


CREATE TABLE IF NOT EXISTS test.newtable AS SELECT 19 AS century, 1900 AS year_start, 1999 AS year_end UNION ALL SELECT 20, 2000, 2999;


CREATE TABLE IF NOT EXISTS test.newtable_crossproject
AS
SELECT is_male, century, COUNT(*) cnt FROM EXTERNAL_QUERY(
    'xxxxx',
    '''SELECT is_male, year
       FROM natality'''
  ) AS r
CROSS JOIN test.newtable y
WHERE r.year >= y.year_start AND r.year <= y.year_end
GROUP BY 1,2;

SELECT * FROM test.newtable_crossproject;