#!/bin/bash

#Creating HDFS directory yelp-checkin to host the JSON file
hdfs dfs -mkdir yelp-checkin
#Copying JSON file to yelp-checkin
hdfs dfs -put yelp_academic_dataset_checkin.json yelp-checkin
#Creating yelp-1 directory in HDFS filesystem to save the outputs from reducers
hdfs dfs -mkdir yelp-1
#Creating yelp-1 and yelp-1/checkin-count/ in Local filesystem
mkdir yelp-1
mkdir yelp-1/checkin-count/

#Changing permission to allow Hive
hdfs dfs -chmod -R o+w .
