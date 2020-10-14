--Creating business table
CREATE TABLE business (business_id string, bus_name string, bus_address string, bus_city string, bus_state string, bus_postal_code string, bus_latitude float, bus_longitude float, bus_stars float, bus_review_count int, bus_is_open tinyint, bus_attributes string, bus_categories string, bus_hours string);
--Populating business table from raw_business
FROM raw_business INSERT OVERWRITE TABLE business SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.name'), get_json_object(json_response, '$.address'), get_json_object(json_response, '$.city'), get_json_object(json_response, '$.state'), get_json_object(json_response, '$.postal_code'), get_json_object(json_response, '$.latitude'), get_json_object(json_response, '$.longitude'),get_json_object(json_response, '$.stars'), get_json_object(json_response, '$.review_count'), get_json_object(json_response, '$.is_open'), cast(get_json_object(json_response, '$.attributes') as string),get_json_object(json_response, '$.categories'), get_json_object(json_response, '$.hours');


--Creating checkin table
CREATE TABLE checkin (business_id string, checkin_dates string);
--Populating checkin table based on the raw_checkin table.This command splits the raw data into two columns.
FROM raw_checkin INSERT OVERWRITE TABLE checkin SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.date');

--Creating review table
CREATE TABLE review (review_id string, rev_user_id string, rev_business_id string, rev_stars int, rev_useful int, rev_funny int, rev_cool int, rev_text string, rev_date date);
--Populating review table from raw_review
FROM raw_review INSERT OVERWRITE TABLE review SELECT get_json_object(json_response, '$.review_id'), get_json_object(json_response, '$.user_id'), get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.stars'), get_json_object(json_response, '$.useful'), get_json_object(json_response, '$.funny'), get_json_object(json_response, '$.cool'), get_json_object(json_response, '$.text'), cast(get_json_object(json_response, '$.date') as timestamp);



--Creating table 'tip'. It has five columns: user_id, business_id, text, date, compliment_count.
CREATE TABLE tip (user_id STRING, business_id STRING, text STRING, tip_date STRING, compliment_count STRING);
--Populating tip table based on the raw_tip table. This command splits the raw data into 5 columns.
FROM raw_tip INSERT OVERWRITE TABLE tip SELECT get_json_object(json_response,'$.user_id'), get_json_object(json_response,'$.business_id'), get_json_object(json_response,'$.text'), get_json_object(json_response,'$.date'), get_json_object(json_response,'$.compliment_count');


--Creating table users
CREATE TABLE users (user_id string, user_name string, user_review_count int, user_yelping_since date, user_friends string, user_useful int, user_funny int, user_cool int, user_fans int, user_elite string, user_average_stars float, user_compliment_hot int, user_compliment_more int, user_compliment_profile int, user_compliment_cute int, user_compliment_list int, user_compliment_note int, user_compliment_plain int, user_compliment_cool int, user_compliment_funny int, user_compliment_writer int, user_compliment_photos int);
--Populating users from raw_user
FROM raw_user INSERT OVERWRITE TABLE users SELECT get_json_object(json_response, '$.user_id'), get_json_object(json_response, '$.name'), get_json_object(json_response, '$.review_count'), cast(get_json_object(json_response, '$.yelping_since') as date), get_json_object(json_response, '$.friends'), get_json_object(json_response, '$.useful'), get_json_object(json_response, '$.funny'), get_json_object(json_response, '$.cool'), get_json_object(json_response, '$.fans'), get_json_object(json_response, '$.elite'), get_json_object(json_response, '$.average_stars'), get_json_object(json_response, '$.compliment_hot'), get_json_object(json_response, '$.compliment_more'), get_json_object(json_response, '$.compliment_profile'), get_json_object(json_response, '$.compliment_cute'), get_json_object(json_response, '$.compliment_list'), get_json_object(json_response, '$.compliment_note'), get_json_object(json_response, '$.compliment_plain'), get_json_object(json_response, '$.compliment_cool'), get_json_object(json_response, '$.compliment_funny'), get_json_object(json_response, '$.compliment_writer'), get_json_object(json_response, '$.compliment_photos');

--Creating an attribute table for business
--not finished: create table business_attribute as select business_id, bus_attributes  explode(split(bus_attributes, ','))
