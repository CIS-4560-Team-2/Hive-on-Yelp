create view bus_categories as select business_id, ltrim(bus_category) bus_category from business lateral view explode(split(bus_categories, ',')) dummy as bus_category;

-- Top 5 category
select bus_category, count(business_id) bus_category_count from bus_categories group by bus_category order by bus_category_count desc limit 5;


create view bus_category_restaurant as select business_id bus_restaurant_id from bus_categories where bus_category='Restaurants';

-- Top categories that goes with restaurant
select bus_category, count(business_id) bus_category_count from bus_categories where business_id in (select bus_restaurant_id from bus_category_restaurant) group by bus_category order by bus_category_count desc limit 10;


--Not so much with restaurants
select bus_category, count(business_id) bus_category_count from bus_categories where business_id in (select bus_restaurant_id from bus_category_restaurant) group by bus_category order by bus_category_count limit 10;