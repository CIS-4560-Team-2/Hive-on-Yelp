# Hive-on-Yelp
## Introduction

This repository is hosting our analysis of Yelp Dataset. Yelp Dataset is available here: https://www.yelp.com/dataset/download

There are five JSON files in this dataset: business, checkin, review, user, and tip. Our downloaded version of the dataset is 9.8 GB when uncompressed. 

We have run descriptive analytics on the Yelp dataset to find out how different features of Yelp evolved throughout last decades, how businesses in different states receive different level of ratings, what people express in their tips by doing sentiment analysis. 
For the sentiment analysis, we have used a dictionary dataset found here: https://s3.amazonaws.com/hipicdatasets/dictionary.tsv

## Structure

preparation.sh prepares the user machine by extracting JSON files from the archive and moving the JSON files to HDFS filesystem.

complete_tables.hql file creates initial raw tables based on the five JSON files, and standard tables based on the raw tables. 

HiveQL related to processing and analysis of data are saved in sub-directories. These sub-directories may also contain necessary bash script files for input and output handling in the user machine.

