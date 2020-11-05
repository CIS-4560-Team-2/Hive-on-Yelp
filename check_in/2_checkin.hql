--Using Split function to split the checkin_dates strings to arrays of timestamps and Explode function to create new rows for each timestamp. Saving this data into a view.
create view checkin_clean as select business_id, cast(substr(timestamps, 0, 10) as date) checkin_dates from checkin lateral view explode(split(checkin_dates, ', ')) dummy as timestamps;


--check-in counts per day
create table checkin_per_day row format delimited fields terminated by ',' stored as textfile location "/user/malam/yelp/results/checkin_per_day" as select checkin_dates, count(business_id) from checkin_clean group by checkin_dates;

create table checkin_day_state row format delimited fields terminated by ',' stored as textfile location "/user/malam/yelp/results/checkin_day_state" as select bus_state, checkin_dates, count(checkin_clean.business_id) from checkin_clean join business on checkin_clean.business_id = business.business_id group by bus_state, checkin_dates order by bus_state, checkin_dates;




--check-in counts per month per year 
--not complete: create table checkin_month_year_total row format delimited fields terminated by '\t' stored as textfile location "/user/malam/yelp/results/checkin_month_year_total" as select checkin_year, checkin_month, count(business_id) checkin_counts from checkin_month_year group by checkin_year, checkin_month;
--Creating a summary table with GROUP BY command to find out check in information for all businesses.
--not complete: create table checkin_count row format delimited fields terminated by '\t' stored as textfile location "/user/malam/yelp/results/checkin-count"  as select business_id, count(timestamps) from checkin1 group by business_id;



