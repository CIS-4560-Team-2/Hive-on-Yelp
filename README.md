# Hive-on-Yelp
## Introduction

This repository is hosting our analysis of Yelp Dataset. Yelp Dataset is available here: https://www.yelp.com/dataset/download

There are five JSON files in this dataset: business, checkin, review, user, and tip. Our downloaded version of the dataset is 9.8 GB when uncompressed. 

## Structure

preparation.sh prepares the user machine by extracting JSON files from the archive and moving the JSON files to HDFS filesystem.

raw_tables.hql file creates five raw tables based on the five JSON files.

HiveQL related to processing and analysis of data are saved in sub-directories. These sub-directories may also contain two bash script files: pre and post. These files hold necessary commands for input and output handling in the user machine.


Pre and Post files should be run before and after running the HQL files, respectively.
