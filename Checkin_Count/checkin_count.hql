--Creating table raw_checkin from the yelp_academic_dataset_checkin.json file. This json file is saved in the /user/malam/yelp-checkin directory of HDFS file system
create external table raw_checkin (json_response string) stored as textfile location '/user/malam/yelp-checkin';
--Creating yelp_checkin. It has two columns: business_id, checkin_timestamps
create table yelp_checkin (business_id string, checkin_timestamps string);
--Populating yelp_checkin table based on the raw_checkin table.This command splits the raw data into two columns.
FROM raw_checkin INSERT OVERWRITE TABLE yelp_checkin SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.date');
--Using Split function to split the checkin_timestamps strings to arrays of timestamps and Explode function to create new rows for each timestamp. Saving this data into a view.
create view checkin1 as select business_id, timestamps from yelp_checkin lateral view explode(split(checkin_timestamps, ', ')) dummy as timestamps;
--Creating a summary table with GROUP BY command to find out check in information for all businesses.
create table checkin_count stored as textfile location "/user/malam/yelp-1/checkin-count"  as select business_id, count(timestamps) from checkin1 group by business_id;
