#/bin/bash

#Run this commands after running the commands from yelp_checkin.hql file
cd yelp/results/checkin_count/

hdfs dfs -get /user/malam/yelp/results/checkin_count/0000*

cat 0000* > checkin_count_out.csv

cd yelp/results/checkin_month_year_count/

hdfs dfs -get /user/malam/yelp/results/checkin_month_year_total/0*

cat 00* > checkin_month_year_total.csv


#to copy the file from server to Local Computer; run these commands in the local PC
scp malam@129.150.79.19:/home/malam/yelp/results/checkin_count/checkin_count_out.csv checkin_count.csv




