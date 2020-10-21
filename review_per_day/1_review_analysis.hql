create table review_per_day row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/review_per_day' as select rev_date, count(review_id) count_review_day from review group by rev_date order by rev_date;

