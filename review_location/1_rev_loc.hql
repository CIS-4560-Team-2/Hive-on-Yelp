--Creating a view to hold some information from review and business table
create view review_location as select b.business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, rev_text, rev_date from business b join review r on b.business_id = r.rev_business_id;

--Extracting month and year from review_date
create view review_location_yyyymm as select business_id, bus_latitude, bus_longitude, bus_city, bus_state, rev_stars, cast(concat(year(rev_date), '-', month(rev_date), '-', 1) as date) rev_yyyy_mm from review_location;

--Creating a location identifier with City, State, and Latitude and Longitude
create table city_location_mapper row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/city_location_mapper' as select bus_state, regexp_replace(bus_city, ',','') bus_city , min(bus_latitude) bus_latitude, min(bus_longitude) bus_longitude from business group by bus_state, bus_city;

--Creating a location identifier with State using average Latitude and Longitude
create table state_locations row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/state_locations' as select bus_state, avg(bus_latitude) state_latitude, avg(bus_longitude) state_longitude from business group by bus_state;

--Calculating average stars per city
create table review_location_average row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/review_location_average' as select r.bus_state, c.bus_city, c.bus_latitude, c.bus_longitude, avg(rev_stars) avg_stars from review_location r, city_location_mapper c where r.bus_state = c.bus_state and regexp_replace(r.bus_city, ',', '') = c.bus_city group by r.bus_state, c.bus_city, c.bus_latitude, c.bus_longitude order by r.bus_state;


--Counting reviews by stars by location
create table review_category_count row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/review_category' as select  r.rev_yyyy_mm, c.bus_latitude, c.bus_longitude, r.rev_stars,  count(business_id) from review_location_yyyymm r, city_location_mapper c where r.bus_state = c.bus_state and regexp_replace(r.bus_city, ',', '') = c.bus_city group by r.rev_yyyy_mm, c.bus_latitude, c.bus_longitude, r.rev_stars order by r.rev_yyyy_mm, r.rev_stars;


