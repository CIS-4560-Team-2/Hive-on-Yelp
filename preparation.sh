#/bin/bash

#Assuming that yelp_dataset.tar file is downloaded in the user's home directory: /home/USERNAME. All these examples are done using malam as USERNAME

#Since the uncompressed file is almost 10G, there could be storage limitation issues. We are extracting and uploading each files separately

#Yelp dataset available at: https://yelp.com/dataset. Need to use browser to download the file in the users' local computer. After downloading, users can upload the file to the Linux server using SCP:
scp yelp_dataset.tar malam@129.150.79.19:/home/malam/

#downloading necessary files
#dictionary.tsv file for sentiment analysis
wget https://s3.amazonaws.com/hipicdatasets/dictionary.tsv

#States names mapped to the acronym Yelp used for better location identification in Excel 3D Map: https://drive.google.com/file/d/1PkWtxa3VeTZS-WMRcv8yPdQFQ1If7AsR/view 
#Download the file in local system and upload it to Oracle Server by SCP:
scp state_locations.csv malam@129.150.79.19:/home/malam

#creating all directories in HDFS

hdfs dfs -mkdir yelp
hdfs dfs -mkdir yelp/business
hdfs dfs -mkdir yelp/checkin
hdfs dfs -mkdir yelp/review
hdfs dfs -mkdir yelp/tip
hdfs dfs -mkdir yelp/user
hdfs dfs -mkdir yelp/states
hdfs dfs -mkdir yelp/dictionary


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

#uploading the support files to HDFS
hdfs dfs -put dictionary.tsv yelp/dictionary
hdfs dfs -put state_locations.csv yelp/states


#checking if files are uploaded to HDFS properly
hdfs dfs -ls -h yelp/business
hdfs dfs -ls -h yelp/checkin
hdfs dfs -ls -h yelp/review
hdfs dfs -ls -h yelp/tip
hdfs dfs -ls -h yelp/user
hdfs dfs -ls -h yelp/dictionary
hdfs dfs -ls -h yelp/states

#create directory to process & save outputs
hdfs dfs -mkdir yelp/results

#changing permission to avoid errors in Hive
hdfs dfs -chmod -R o+w .