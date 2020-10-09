#/bin/bash

#Run this commands after running the commands from yelp_checkin.hql file
cd yelp-1/checkin-count/

hdfs dfs -get /user/malam/yelp-1/checkin-count/0000*

cat 0000* > checkin_count_out.csv

scp malam@129.150.79.19:/home/malam/yelp-1/checkin-count/checkin_count_out.csv checkin_count.csv




