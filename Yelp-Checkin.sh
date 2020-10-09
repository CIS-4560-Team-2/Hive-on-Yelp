hdfs dfs -mkdir yelp-checkin
hdfs dfs -mkdir yelp-1
hdfs dfs -put yelp_academic_dataset_checkin.json yelp-checkin
mkdir yelp-1
mkdir yelp-1/checkin-count/
cd yelp-1/checkin-count/

hdfs dfs -get /user/malam/yelp-1/checkin-count/0000*

cat 0000* > checkin_count_out.csv

scp malam@129.150.79.19:/home/malam/yelp-1/checkin-count/checkin_count_out.csv checkin_count.csv


hdfs dfs -chmod -R o+w .

