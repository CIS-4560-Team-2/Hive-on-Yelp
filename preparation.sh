#/bin/bash

#Assuming that yelp_dataset.tar file is downloaded in the user's home directory: /home/USERNAME. All these examples are done using malam as USERNAME

#Since the uncompressed file is almost 10G, there could be storage limitation issues. We are extracting and uploading each files separately

#creating all directories in HDFS

hdfs dfs -mkdir yelp
hdfs dfs -mkdir yelp/business
hdfs dfs -mkdir yelp/checkin
hdfs dfs -mkdir yelp/review
hdfs dfs -mkdir yelp/tip
hdfs dfs -mkdir yelp/user

#extracting, moving, and then deleting local copy
tar -xvf yelp_dataset.tar ./yelp_academic_dataset_business.json
hdfs dfs -put yelp_academic_dataset_business.json yelp/business
rm yelp_academic_dataset_business.json

tar -xvf yelp_dataset.tar ./yelp_academic_dataset_checkin.json
hdfs dfs -put yelp_academic_dataset_checkin.json yelp/checkin
rm yelp_academic_dataset_checkin.json

tar -xvf yelp_dataset.tar ./yelp_academic_dataset_review.json
hdfs dfs -put yelp_academic_dataset_review.json yelp/review
rm yelp_academic_dataset_review.json

tar -xvf yelp_dataset.tar ./yelp_academic_dataset_tip.json
hdfs dfs -put yelp_academic_dataset_tip.json yelp/tip
rm yelp_academic_dataset_tip.json

tar -xvf yelp_dataset.tar ./yelp_academic_dataset_user.json
hdfs dfs -put yelp_academic_dataset_user.json yelp/
rm yelp_academic_dataset_user.json


#checking if files are uploaded to HDFS properly
hdfs dfs -ls -h yelp/business
hdfs dfs -ls -h yelp/checkin
hdfs dfs -ls -h yelp/review
hdfs dfs -ls -h yelp/tip
hdfs dfs -ls -h yelp/user

#create directory to process & save outputs
hdfs dfs -mkdir yelp/results

#changing permission to avoid errors in Hive
hdfs dfs -chmod -R o+w .