--Creating a view to hold some information from review and business table
create view review_location as select b.business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, rev_text, rev_date from business b join review r on b.business_id = r.rev_business_id;

--Extracting month and year from review_date and creating a single date for each month in each year
create view review_location_yyyymm as select business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, cast(concat(year(rev_date), '-', month(rev_date), '-', 1) as date) rev_yyyy_mm from review_location;


--Counting rating stars per state
create table rating_category_count row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/rating_category' as select  s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars, count(business_id) from review_location_yyyymm r join state_locations s where r.bus_state = s.bus_state group by s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars order by s.country_names, s.state_names, r.rev_yyyy_mm, r.rev_stars;


--Calculating average stars per state
create table review_location_average row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/review_location_average' as select s.country_names, s.state_names, avg(rev_stars) avg_stars from review_location_yyyymm r, state_locations s where r.bus_state = s.bus_state group by s.country_names, s.state_names order by s.country_names, s.state_names;