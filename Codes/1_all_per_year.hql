--Using Split function to split the checkin_dates strings to arrays of timestamps and Explode function to create new rows for each timestamp. Saving this data into a view.
CREATE VIEW checkin_clean as select business_id, cast(substr(timestamps, 0, 10) as date) checkin_dates from checkin lateral view explode(split(checkin_dates, ', ')) dummy as timestamps;

--Creating checkin_per_year table to count all check-ins per year 
CREATE TABLE checkin_per_year as SELECT checkin_year, count(business_id) checkin_count FROM (SELECT year(checkin_dates) checkin_year, business_id FROM checkin_clean) checkin_temp GROUP BY checkin_year ORDER BY checkin_year;

--Creating review_per_year table
CREATE TABLE review_per_year as SELECT rev_year, count(review_id) review_count FROM (SELECT year(rev_date) rev_year, review_id FROM review) review_temp GROUP BY rev_year ORDER BY rev_year;


--Creating tip per year table
CREATE TABLE tip_per_year as SELECT tip_year, count(tip_id) tip_count FROM (SELECT year(tip_date) tip_year, tip_id FROM tip_modified) tip_summary GROUP BY tip_year ORDER BY tip_year;


--Creating user_elite view to allow further sorting
CREATE VIEW users_elite as SELECT user_id, user_elite_year FROM users lateral view explode(split(user_elite, ',')) dummy as user_elite_year;

--Creating user_new_per_year table to count newly added users per year
CREATE TABLE user_new_per_year as SELECT user_year, count(user_id) new_users_count FROM (SELECT year(user_yelping_since) user_year, user_id FROM users_summary) users_temp GROUP BY user_year ORDER BY user_year;

--Creating user_elite_per_year to count number of elite users per year
CREATE TABLE user_elite_per_year as SELECT user_elite_year, count(user_id) elite_users_count FROM users_elite GROUP BY user_elite_year ORDER BY user_elite_year;


--Joining all per_year tables to generate combined report
CREATE TABLE yelp_per_year ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/UNAME/yelp/results/yelp_per_year' as SELECT user_year years, new_users_count, review_count, elite_users_count, tip_count, checkin_count FROM user_new_per_year full outer join review_per_year on user_year = rev_year full outer join user_elite_per_year on user_year = user_elite_year full outer join tip_per_year on user_year = tip_year full outer join checkin_per_year on user_year = checkin_year where user_year is not null ORDER BY years;