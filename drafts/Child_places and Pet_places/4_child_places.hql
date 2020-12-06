--Getting all the businesses where one of the categories is Child
CREATE VIEW child_places_categories AS SELECT country_names, state_names, bus_review_count, bus_categories FROM business JOIN state_locations ON business.bus_state = state_locations.bus_state WHERE bus_categories LIKE '%Child%' ORDER BY country_names, state_names;

No rows affected (0.443 seconds)

--Using Explode() method to split categories into new rows
CREATE VIEW child_places AS SELECT country_names, state_names, bus_review_count, LTRIM(bus_category) bus_category from child_places_categories lateral view explode(split(bus_categories, ',')) dummy as bus_category;

No rows affected (0.247 seconds)

--Choosing top 5 categories associated with Child Places
CREATE VIEW top5child as SELECT bus_category, sum(bus_review_count) bus_category_review_count from child_places group by bus_category order by bus_category_review_count desc limit 5;

No rows affected (0.257 seconds)

+-------------------------+--------------------------------------+--+
| top5child.bus_category  | top5child.bus_category_review_count  |
+-------------------------+--------------------------------------+--+
| Shopping                | 9889                                 |
| Local Services          | 9815                                 |
| Child Care & Day Care   | 9038                                 |
| Fashion                 | 8898                                 |
| Children's Clothing     | 8898                                 |
+-------------------------+--------------------------------------+--+
5 rows selected (19.313 seconds)

--Aggregating review_counts by location
CREATE TABLE child_places_summary ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/malam/yelp/results/child_places_summary/' as SELECT country_names, state_names, bus_category, sum(bus_review_count) review_count from child_places where bus_category in (select bus_category from top5child) tmp group by country_names, state_names, bus_category order by country_names, state_names, bus_category; 

INFO  : Table malam.child_places_summary stats: [numFiles=1, numRows=55, totalSize=1875, rawDataSize=1820]
No rows affected (27.465 seconds)


--Getting all the businesses where one of the categories is Pet
CREATE VIEW pet_places_categories AS SELECT country_names, state_names, bus_review_count, bus_categories FROM business JOIN state_locations ON business.bus_state = state_locations.bus_state WHERE bus_categories LIKE '%Pet%' ORDER BY country_names, state_names;

--Using Explode() method to split categories into new rows
CREATE VIEW pet_places AS SELECT country_names, state_names, bus_review_count, LTRIM(bus_category) bus_category from pet_places_categories lateral view explode(split(bus_categories, ',')) dummy as bus_category;

--Aggregating review_counts by location
CREATE TABLE pet_places_summary ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/malam/yelp/results/pet_places_summary/' as SELECT country_names, state_names, bus_category, sum(bus_review_count) review_count from pet_places group by country_names, state_names, bus_category order by country_names, state_names, bus_category;