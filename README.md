# Hive-on-Yelp
## Introduction

This repository is hosting our analysis of Yelp Dataset. Yelp Dataset is available here: https://www.yelp.com/dataset/download


Complete tutorial is available here: https://tinyurl.com/yelp-hive-tutorial



There are five JSON files in this dataset: business, checkin, review, user, and tip. Our downloaded version of the dataset is 9.8 GB when uncompressed. 

We have run descriptive analytics on the Yelp dataset to find out how different features of Yelp evolved throughout last decades, how businesses in different states receive different level of ratings, what people express in their tips by doing sentiment analysis. 

For the sentiment analysis, we have used a dictionary dataset found here: https://s3.amazonaws.com/hipicdatasets/dictionary.tsv

state_locations.txt file is used for producing better location detection in Excel 3D Map; it can be found here: https://drive.google.com/uc?id=1dFrIcQuBhaANRHHvnzbthfU3HHVDRy7Y&export=download

## Structure

### Deliverables
All the final submissions are saved in this directory.

### Outputs
This directory holds all the final output files. 

### Codes
This directory contains all the final codes in one place.

### drafts
This directory contains all the previous versions and ongoing works

### Workflow Chart.jpg 
This flow chart explains the top-level view of overall operation.  

### preparation.sh
This file prepares the user machine by extracting JSON files from the archive and moving the JSON files to HDFS filesystem.

### primary_tables.hql 
This file creates initial raw tables based on the five JSON files, and standard tables based on the raw tables. 

### state_locations.txt
Maps state acronyms used in the Yelp Dataset to complete state names with country names for better map rendering.

