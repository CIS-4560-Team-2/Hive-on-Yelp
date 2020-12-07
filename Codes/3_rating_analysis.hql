--Creating a view to hold some information FROM review and business table
CREATE VIEW review_location as SELECT b.business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, rev_text, rev_date FROM business b JOIN review r ON b.business_id = r.rev_business_id;

--No rows affected (0.28 seconds)

--Extracting month and year FROM review_date and creating a single date for each month in each year
CREATE VIEW review_location_yyyymm as SELECT business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, cast(concat(year(rev_date), '-', month(rev_date), '-', 1) as date) rev_yyyy_mm FROM review_location;

--No rows affected (0.232 seconds)

--Counting rating stars per state
CREATE TABLE rating_category_count ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/UNAME/yelp/results/rating_category' as SELECT  s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars, count(business_id) FROM review_location_yyyymm r JOIN state_locations s where r.bus_state = s.bus_state group by s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars order by s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars;

--No rows affected (56.343 seconds)

SELECT * FROM rating_category_count LIMIT 5;

| rating_category_count.country_names  | rating_category_count.state_names  | rating_category_count.rev_yyyy_mm  | rating_category_count.rev_stars  | rating_category_count._c4  |

|  Canada                              | Alberta                            | 2008-08-01                         | 1                                | 1                          |
|  Canada                              | Alberta                            | 2008-08-01                         | 3                                | 5                          |
|  Canada                              | Alberta                            | 2008-08-01                         | 4                                | 24                         |
|  Canada                              | Alberta                            | 2008-08-01                         | 5                                | 21                         |
|  Canada                              | Alberta                            | 2008-09-01                         | 1                                | 3                          |
+--------------------------------------+------------------------------------+------------------------------------+----------------------------------+----------------------------+--+
5 rows selected (0.144 seconds)