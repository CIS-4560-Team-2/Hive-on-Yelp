--Creating table 'tip'. It has five columns: user_id, business_id, text, date, compliment_count.

CREATE TABLE tip (user_id STRING, business_id STRING, text STRING, tip_date STRING, compliment_count STRING);

--Populating tip table based on the raw_tip table. This command splits the raw data into 5 columns.

FROM raw_tip INSERT OVERWRITE TABLE tip SELECT get_json_object(json_response,'$.user_id'), get_json_object(json_response,'$.business_id'), regexp_replace(get_json_object(json_response,'$.text'), '\n', ' '), cast(substr(get_json_object(json_response,'$.date'),0,10) as date), cast(get_json_object(json_response,'$.compliment_count') as int);
--Create table 'dictionary', which has polarity to show each word’s meaning implied as positive or negative.

CREATE EXTERNAL TABLE if not exists dictionary (type string, length int, word string, pos string, stemmed string, polarity string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/user/malam/yelp/dictionary';

--Create 3 views that will allow us to copmute tip sentiment.
--Compute sentiment
  
  create view IF NOT EXISTS l1_tip as
  select id, words
  from 
  s_text
  lateral view explode(sentences(lower(text))) dummy as words;

  create view IF NOT EXISTS l2_tip as
  select id, word
  from l1_tip
  lateral view explode( words ) dummy as word;

-- Compute sentiment as numeric values
  create view IF NOT EXISTS l3_tip as select
  id user_id,
  l2_tip.word,
  case d.polarity
  when 'negative' then -1
  when 'positive' then 1
  else 0 end as polarity
  from l2_tip left outer join dictionary d on l2_tip.word = d.word;
  
--Assign whether a tip was positive, neutral, or negative.
create table IF NOT EXISTS tip_sentiment row format delimited fields terminated by ',' stored as textfile location '/user/malam/yelp/results/tip_sentiment/' as select user_id, case when sum( polarity ) > 0 then 'positive' when sum( polarity ) < 0 then 'negative' else 'neutral' end as sentiment from l3_tip group by user_id;
