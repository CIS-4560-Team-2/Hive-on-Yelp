--Creating table raw_business from the yelp_academic_dataset_business.json file. This json file is saved in the /user/malam/yelp/business directory of HDFS file system
create external table raw_business (json_response string) stored as textfile location '/user/malam/yelp/business';
--Creating business table
CREATE TABLE business (business_id string, bus_name string, bus_address string, bus_city string, bus_state string, bus_postal_code string, bus_latitude float, bus_longitude float, bus_stars float, bus_review_count int, bus_is_open tinyint, bus_attributes string, bus_categories string, bus_hours string);
--Populating business table from raw_business
FROM raw_business INSERT OVERWRITE TABLE business SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.name'), get_json_object(json_response, '$.address'), get_json_object(json_response, '$.city'), get_json_object(json_response, '$.state'), get_json_object(json_response, '$.postal_code'), get_json_object(json_response, '$.latitude'), get_json_object(json_response, '$.longitude'),get_json_object(json_response, '$.stars'), get_json_object(json_response, '$.review_count'), get_json_object(json_response, '$.is_open'), cast(get_json_object(json_response, '$.attributes') as string),get_json_object(json_response, '$.categories'), get_json_object(json_response, '$.hours');

--Creating table raw_checkin from the yelp_academic_dataset_checkin.json file. This json file is saved in the /user/malam/yelp/checkin directory of HDFS file system
create external table raw_checkin (json_response string) stored as textfile location '/user/malam/yelp/checkin';
--Creating checkin table
CREATE TABLE checkin (business_id string, checkin_dates string);
--Populating checkin table based on the raw_checkin table.This command splits the raw data into two columns.
FROM raw_checkin INSERT OVERWRITE TABLE checkin SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.date');


--Creating table raw_review from the yelp_academic_dataset_review.json file. This json file is saved in the /user/malam/yelp/review directory of HDFS file system
create external table raw_review (json_response string) stored as textfile location '/user/malam/yelp/review';
--Creating review table
CREATE TABLE review (review_id string, rev_user_id string, rev_business_id string, rev_stars int, rev_useful int, rev_funny int, rev_cool int, rev_text string, rev_timestamp string, rev_date date);
--Populating review table from raw_review
FROM raw_review INSERT OVERWRITE TABLE review SELECT get_json_object(json_response, '$.review_id'), get_json_object(json_response, '$.user_id'), get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.stars'), get_json_object(json_response, '$.useful'), get_json_object(json_response, '$.funny'), get_json_object(json_response, '$.cool'), regexp_replace(regexp_replace(get_json_object(json_response,'$.text'), '\n', ' '), '\r', ' '), get_json_object(json_response, '$.date'), cast(substr(get_json_object(json_response, '$.date'),0,10) as date);

--Creating table raw_tip from the yelp_academic_dataset_tip.json file. This json file is saved in the /user/malam/yelp/tip directory of HDFS file system
create external table raw_tip (json_response string) stored as textfile location '/user/malam/yelp/tip';
--Creating table 'tip'. It has five columns: tip_user_id, tip_business_id, tip_text, tip_date, tip_compliment_count.
CREATE TABLE tip (tip_user_id STRING, tip_business_id STRING, tip_text STRING, tip_date date, tip_compliment_count int);
--Populating tip table based on the raw_tip table. This command splits the raw data into 5 columns.
FROM raw_tip INSERT OVERWRITE TABLE tip SELECT get_json_object(json_response,'$.user_id'), get_json_object(json_response,'$.business_id'), regexp_replace(get_json_object(json_response,'$.text'), '\n', ' '), cast(substr(get_json_object(json_response,'$.date'),0,10) as date), cast(get_json_object(json_response,'$.compliment_count') as int);
--Creating a view tip_modified with an added column tip_id, which will act as a row identifier/primary key;
create view tip_modified as select row_number() over() tip_id, tip_user_id, tip_business_id, tip_text, tip_date, tip_compliment_count from tip;


--Creating table raw_user from the yelp_academic_dataset_user.json file. This json file is saved in the /user/malam/yelp/user directory of HDFS file system
create external table raw_user (json_response string) stored as textfile location '/user/malam/yelp/user';
--Creating table users
CREATE TABLE users (user_id string, user_name string, user_review_count int, user_yelping_since string, user_friends string, user_useful int, user_funny int, user_cool int, user_fans int, user_elite string, user_average_stars float, user_compliment_hot int, user_compliment_more int, user_compliment_profile int, user_compliment_cute int, user_compliment_list int, user_compliment_note int, user_compliment_plain int, user_compliment_cool int, user_compliment_funny int, user_compliment_writer int, user_compliment_photos int);
--Populating users from raw_user
FROM raw_user INSERT OVERWRITE TABLE users SELECT get_json_object(json_response, '$.user_id'), get_json_object(json_response, '$.name'), get_json_object(json_response, '$.review_count'), get_json_object(json_response, '$.yelping_since'), get_json_object(json_response, '$.friends'), get_json_object(json_response, '$.useful'), get_json_object(json_response, '$.funny'), get_json_object(json_response, '$.cool'), get_json_object(json_response, '$.fans'), get_json_object(json_response, '$.elite'), get_json_object(json_response, '$.average_stars'), get_json_object(json_response, '$.compliment_hot'), get_json_object(json_response, '$.compliment_more'), get_json_object(json_response, '$.compliment_profile'), get_json_object(json_response, '$.compliment_cute'), get_json_object(json_response, '$.compliment_list'), get_json_object(json_response, '$.compliment_note'), get_json_object(json_response, '$.compliment_plain'), get_json_object(json_response, '$.compliment_cool'), get_json_object(json_response, '$.compliment_funny'), get_json_object(json_response, '$.compliment_writer'), get_json_object(json_response, '$.compliment_photos');



--Creating state_locations table 
CREATE EXTERNAL TABLE state_locations (bus_state string, state_names string, country_names string) row format delimited fields terminated by '\t' stored as textfile location '/user/malam/yelp/states/';