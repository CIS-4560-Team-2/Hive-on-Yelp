hdfs dfs -get yelp/results/yelp_per_year/0*

cat 0* > all_per_year.csv

scp malam@129.150.79.19:/home/malam/all_per_year.csv all_per_year.csv