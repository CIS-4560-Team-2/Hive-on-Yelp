--Creating business table
CREATE TABLE business (business_id string, bus_name string, bus_address string, bus_city string, bus_state string, bus_postal_code string, bus_latitude float, bus_longitude float, bus_stars float, bus_review_count int, bus_is_open tinyint, bus_attributes string, bus_categories string, bus_hours string);
--Populating business table from raw_business
FROM raw_business INSERT OVERWRITE TABLE business SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.name'), get_json_object(json_response, '$.address'), get_json_object(json_response, '$.city'), get_json_object(json_response, '$.state'), get_json_object(json_response, '$.postal_code'), get_json_object(json_response, '$.latitude'), get_json_object(json_response, '$.longitude'),get_json_object(json_response, '$.stars'), get_json_object(json_response, '$.review_count'), get_json_object(json_response, '$.is_open'), cast(get_json_object(json_response, '$.attributes') as string),get_json_object(json_response, '$.categories'), get_json_object(json_response, '$.hours');


--Creating an attribute table for business
 create table business_attribute as select business_id, bus_attributes  explode(split(bus_attributes, ','))

--Creating checkin table
create table checkin (business_id string, checkin_dates string);
--Populating checkin table based on the raw_checkin table.This command splits the raw data into two columns.
FROM raw_checkin INSERT OVERWRITE TABLE checkin SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.date');