hdfs dfs -get yelp/results/review_per_day/0*

cat 00* > review_per_day.csv

scp malam@129.150.79.19:/home/malam/review_per_day.csv review_per_day.csv

