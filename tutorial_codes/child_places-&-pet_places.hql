--Create table child_places--
CREATE TABLE child_places ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/malam/yelp/results/child_places/' AS SELECT country_names, state_names, bus_review_count, bus_categories FROM business JOIN state_locations ON business.bus_state = state_locations.bus_state WHERE bus_categories LIKE '%Child%' ORDER BY country_names, state_names;

--Create table pet_places--
CREATE TABLE pet_places ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/malam/yelp/results/pet_places/' AS SELECT country_names, state_names, bus_review_count, bus_categories FROM business JOIN state_locations ON business.bus_state = state_locations.bus_state WHERE bus_categories LIKE '%Pets%' ORDER BY country_names, state_names;


