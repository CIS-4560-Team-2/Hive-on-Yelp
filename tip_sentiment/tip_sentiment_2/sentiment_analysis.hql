--Re-creating the CITY_LOCATION_MAPPER table to include 'business_id' column.

create table city_location_mapper_with_business_id row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/city_location_mapper' as select business_id, bus_state, regexp_replace(bus_city, ',','') bus_city , min(bus_latitude) bus_latitude, min(bus_longitude) bus_longitude from business group by business_id, bus_state, bus_city;


--Creating improved TIP table which JOINs city_location_mapper + TIP table by business_id

create table tip2 as select b.business_id, bus_state, user_id, text, tip_date, compliment_count from business b join tip t on b.business_id = t.business_id;

----Create 3 views to allow tip sentiment computation.

CREATE EXTERNAL TABLE if not exists dictionary (type string, length int, word string, pos string, stemmed string, polarity string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/user/malam/yelp/dictionary';

create view IF NOT EXISTS l1_tip2 as select business_id, bus_state, user_id, words, tip_date from tip2 lateral view explode(sentences(lower(text))) dummy as words;

create view IF NOT EXISTS l2_tip2 as select business_id, bus_state, user_id, word, tip_date from l1_tip2 lateral view explode( words ) dummy as word;

create view IF NOT EXISTS l3_tip2 as select business_id, bus_state, user_id, tip_date, l2_tip2.word, case d.polarity when 'negative' then -1 when 'positive' then 1 else 0 end as polarity from l2_tip2 left outer join dictionary d on l2_tip2.word = d.word;

create table IF NOT EXISTS tip_sentiment2 row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/tip_sentiment2' as select business_id, bus_state, user_id, tip_date, case when sum( polarity ) > 0 then 'positive' when sum( polarity ) < 0 then 'negative' else 'neutral' end as sentiment from l3_tip2 group by business_id, bus_state, user_id, tip_date;
