mkdir yelp/results/review_location_average
cd yelp/results/review_location_average

hdfs dfs -get yelp/results/review_location_average/0*

cat 00* > review_location_average.csv


scp malam@129.150.79.19:/home/malam/yelp/results/review_location_average/review_location_average.csv review_location_average.csv