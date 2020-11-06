--Create table child_places--
CREATE TABLE child_places ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/malam/yelp/results/child_places/' AS SELECT country_names, state_names, bus_review_count, bus_categories FROM business JOIN state_locations ON business.bus_state = state_locations.bus_state WHERE bus_categories LIKE '%Child%' ORDER BY country_names, state_names;


--Alternate attempts
--Getting all the businesses where one of the category is Child
CREATE VIEW child_places_categories AS SELECT country_names, state_names, bus_review_count, bus_categories FROM business JOIN state_locations ON business.bus_state = state_locations.bus_state WHERE bus_categories LIKE '%Child%' ORDER BY country_names, state_names;

--Using Explode() method to split categories into new rows
CREATE VIEW child_places AS SELECT country_names, state_names, bus_review_count, LTRIM(bus_category) bus_category from child_places_categories lateral view explode(split(bus_categories, ',')) dummy as bus_category;

--Aggregating reviw_counts by location
CREATE TABLE child_places_summary ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/malam/yelp/results/child_places_summary/' as SELECT country_names, state_names, bus_category, sum(bus_review_count) review_count from child_places group by country_names, state_names, bus_category order by country_names, state_names, bus_category; 

--Create table pet_places--
CREATE TABLE pet_places ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/malam/yelp/results/pet_places/' AS SELECT country_names, state_names, bus_review_count, bus_categories FROM business JOIN state_locations ON business.bus_state = state_locations.bus_state WHERE bus_categories LIKE '%Pets%' ORDER BY country_names, state_names;


