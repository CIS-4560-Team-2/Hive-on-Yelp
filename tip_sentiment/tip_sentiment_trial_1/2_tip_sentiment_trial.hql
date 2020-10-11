--Creating table 'tip'. It has five columns: user_id, business_id, text, date, compliment_count.

  CREATE TABLE tip (user_id STRING, business_id STRING, text STRING, tip_date STRING, compliment_count STRING);

--Populating tip table based on the raw_tip table. This command splits the raw data into 5 columns.

  FROM raw_tip INSERT OVERWRITE TABLE tip 
  SELECT get_json_object(json_response,'$.user_id'), get_json_object(json_response,'$.business_id'), get_json_object(json_response,'$.text')
  , get_json_object(json_response,'$.date'), get_json_object(json_response,'$.compliment_count');

--Create table 'dictionary', which has polarity to show each word’s meaning implied as positive or negative.

CREATE EXTERNAL TABLE if not exists dictionary (type string, length int, word string, pos string, stemmed string, polarity string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/user/malam/tmp/data/dictionary';

