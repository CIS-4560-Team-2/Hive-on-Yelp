create external table raw_checkin (json_response string) stored as textfile location '/user/malam/yelp-checkin';
create table yelp_checkin (business_id string, checkin_timestamps string);
FROM raw_checkin INSERT OVERWRITE TABLE yelp_checkin SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.date');
create view checkin1 as select business_id, timestamps from yelp_checkin lateral view explode(split(checkin_timestamps, ', ')) dummy as timestamps;
create table checkin_count stored as textfile location "/user/malam/yelp-1/checkin-count"  as select business_id, count(timestamps) from checkin1 group by business_id;
