--Creating business table
CREATE TABLE business (business_id string, bus_name string, bus_address string, bus_city string, bus_state string, bus_postal_code string, bus_latitude float, bus_longitude float, bus_stars float, bus_review_count int, bus_is_open tinyint, bus_attributes struct<RestaurantsTakeOut: boolean, BusinessParking : struct<bus_park_garage: boolean, bus_park_street: boolean, bus_park_validated: boolean, bus_park_lot: boolean, bus_parkvalet: boolean> >, bus_categories array<string>, bus_hours struct<bus_hours_monday : string, bus_hours_tuesday: string, bus_hours_wednesday: string, bus_hours_thursday: string, bus_hours_friday: string, bus_hours_saturday: string, bus_hours_sunday: string>);
--Populating business table from raw_business
FROM raw_business 



--Creating checkin table
create table checkin (business_id string, checkin_dates string);
--Populating checkin table based on the raw_checkin table.This command splits the raw data into two columns.
FROM raw_checkin INSERT OVERWRITE TABLE checkin SELECT get_json_object(json_response, '$.business_id'), get_json_object(json_response, '$.date');