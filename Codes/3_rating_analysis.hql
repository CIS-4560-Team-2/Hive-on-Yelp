--Creating a view to hold some information FROM review and business table
CREATE VIEW review_location as SELECT b.business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, rev_text, rev_date FROM business b JOIN review r ON b.business_id = r.rev_business_id;


--Extracting month and year FROM review_date and creating a single date for each month in each year
CREATE VIEW review_location_yyyymm as SELECT business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, cast(concat(year(rev_date), '-', month(rev_date), '-', 1) as date) rev_yyyy_mm FROM review_location;


--Counting rating stars per state
CREATE TABLE rating_category_count ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/UNAME/yelp/results/rating_category' as SELECT  s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars, count(business_id) FROM review_location_yyyymm r JOIN state_locations s where r.bus_state = s.bus_state group by s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars order by s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars;


SELECT * FROM rating_category_count LIMIT 5;
