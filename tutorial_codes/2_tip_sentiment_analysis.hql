--Creating dictionary table for senitment analysis
CREATE EXTERNAL TABLE if not exists dictionary (type string, length int, word string, pos string, stemmed string, polarity string) ROW FORMAT DELIMITED FIELDS TERMINATED BY  '\t' STORED AS TEXTFILE LOCATION '/user/UNAME/yelp/dictionary';



----Create 3 views to allow tip sentiment computation.
CREATE VIEW IF NOT EXISTS l1_tip as select tip_id, words from tip_modified lateral view explode(sentences(lower(tip_text))) dummy as words;
CREATE VIEW IF NOT EXISTS l2_tip as select tip_id, word from l1_tip lateral view explode( words ) dummy as word;
CREATE VIEW IF NOT EXISTS l3_tip as select tip_id, l2_tip.word, case d.polarity when 'negative' then -1 when 'positive' then 1 else 0 end as polarity from l2_tip left outer join dictionary d on l2_tip.word = d.word;

--Sentiment in terms of negative or positve or neutral
CREATE TABLE tip_sentiment as SELECT tip_id, case when sum( polarity ) > 0 then 'positive' when sum( polarity ) < 0 then 'negative' else 'neutral' end as tip_sentiment from l3_tip GROUP BY tip_id ORDER BY tip_id;

--a comprehensive report by state, time, and sentiment types
CREATE TABLE tip_sentiment_summary ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION '/user/UNAME/yelp/results/tip_sentiment_summary' as SELECT country_names, state_names, tip_date, tip_sentiment, count(ts.tip_id) FROM tip_modified tm JOIN tip_sentiment ts ON tm.tip_id=ts.tip_id JOIN business ON tm.tip_business_id= business.business_id JOIN state_locations sl ON business.bus_state = sl.bus_state GROUP BY country_names, state_names, tip_date, tip_sentiment ORDER BY country_names, state_names, tip_date;