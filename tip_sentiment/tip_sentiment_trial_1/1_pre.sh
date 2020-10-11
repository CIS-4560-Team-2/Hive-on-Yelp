#!/bin/bash


#Creating tip_sentiment directory within user/malam/yelp/results directory in Local filesystem
mkdir yelp/results/tip_sentiment

#Creating tip_sentiment_trial directory within the user/malam/yelp/results/tip_sentiment directory in Local filesystem
mkdir yelp/tip_sentiment_trial_1

#Download dictionary file to analyze sentiment of data
wget -O dictionary.tsv https://s3.amazonaws.com/hipicdatasets/dictionary.tsv

