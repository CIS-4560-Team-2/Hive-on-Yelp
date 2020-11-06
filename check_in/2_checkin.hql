--Using Split function to split the checkin_dates strings to arrays of timestamps and Explode function to create new rows for each timestamp. Saving this data into a view.
create view checkin_clean as select business_id, cast(substr(timestamps, 0, 10) as date) checkin_dates from checkin lateral view explode(split(checkin_dates, ', ')) dummy as timestamps;


--check-in counts per day
create table checkin_per_day row format delimited fields terminated by ',' stored as textfile location "/user/malam/yelp/results/checkin_per_day" as select checkin_dates, count(business_id) from checkin_clean group by checkin_dates;

--check-in counts per day per state
create table checkin_day_state row format delimited fields terminated by ',' stored as textfile location "/user/malam/yelp/results/checkin_day_state" as select regexp_replace(state_names, '\\"', '') state_names, checkin_dates, count(checkin_clean.business_id) from checkin_clean join business on checkin_clean.business_id = business.business_id join state_locations on business.bus_state = state_locations.bus_state group by state_names, checkin_dates order by state_names, checkin_dates;


