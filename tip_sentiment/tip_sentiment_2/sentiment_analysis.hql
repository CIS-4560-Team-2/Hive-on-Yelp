--Creating a view tip_modified with an added column tip_id, which will act as a row identifier/primary key;
create view tip_modified as select row_number() over() tip_id, tip_user_id, tip_business_id, tip_text, tip_date, tip_compliment_count from tip;

--Creating dictionary table for senitment analysis
CREATE EXTERNAL TABLE if not exists dictionary (type string, length int, word string, pos string, stemmed string, polarity string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/user/malam/yelp/dictionary';



----Create 3 views to allow tip sentiment computation.



create view IF NOT EXISTS l1_tip as select tip_id, words from tip_modified lateral view explode(sentences(lower(tip_text))) dummy as words;

create view IF NOT EXISTS l2_tip as select tip_id, word from l1_tip lateral view explode( words ) dummy as word;


create view IF NOT EXISTS l3_tip as select tip_id, l2_tip.word, case d.polarity when 'negative' then -1 when 'positive' then 1 else 0 end as polarity from l2_tip left outer join dictionary d on l2_tip.word = d.word;

--Sentiment in terms of negative or positve or neutral
create table tip_sentiment as select tip_id, case when sum( polarity ) > 0 then 'positive' when sum( polarity ) < 0 then 'negative' else 'neutral' end as tip_sentiment from l3_tip group by tip_id order by tip_id;

--a comprehensive report by state, time, and sentiment types
create table tip_sentiment_summary row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/tip_sentiment_summary' as select bus_state, tip_date, tip_sentiment, count(ts.tip_id) from tip_modified tm join tip_sentiment ts on tm.tip_id=ts.tip_id join business on tm.tip_business_id= business.business_id group by bus_state, tip_date, tip_sentiment order by bus_state, tip_date;