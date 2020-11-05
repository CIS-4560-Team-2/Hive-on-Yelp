--Creating checkin_per_year table to count all check-ins per year 
create table checkin_per_year as select checkin_year, count(business_id) checkin_count from (select year(checkin_dates) checkin_year, business_id from checkin_clean) checkin_temp group by checkin_year order by checkin_year;

--Creating review_per_year table
create table review_per_year as select rev_year, count(review_id) review_count from (select year(rev_date) rev_year, review_id from review) review_temp group by rev_year order by rev_year;


--Creating a view tip_modified with an added column tip_id, which will act as a row identifier/primary key;
create view tip_modified as select row_number() over() tip_id, tip_user_id, tip_business_id, tip_text, tip_date, tip_compliment_count from tip;

--Creating tip per year table
create table tip_per_year as select tip_year, count(tip_id) tip_count from (select year(tip_date) tip_year, tip_id from tip_modified) tip_summary group by tip_year order by tip_year;


--Creating user_elite view to allow further sorting
create view users_elite as select user_id, user_elite_year from users lateral view explode(split(user_elite, ',')) dummy as user_elite_year;

--Creating user_new_per_year table to count newly added users per year
create table user_new_per_year as select user_year, count(user_id) new_users_count from (select year(user_yelping_since) user_year, user_id from users_summary) users_temp group by user_year order by user_year;

--Creating user_elite_per_year to count number of elite users per year
create table user_elite_per_year as select user_elite_year, count(user_id) elite_users_count from users_elite group by user_elite_year order by user_elite_year;


--Joining all per_year tables to generate combined report
create table yelp_per_year row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/yelp_per_year' as select user_year years, new_users_count, review_count, elite_users_count, tip_count, checkin_count from user_new_per_year full outer join review_per_year on user_year = rev_year full outer join user_elite_per_year on user_year = user_elite_year full outer join tip_per_year on user_year = tip_year full outer join checkin_per_year on user_year = checkin_year where user_year is not null order by years;