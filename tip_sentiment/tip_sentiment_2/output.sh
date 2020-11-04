cd yelp/results/tip_sentiment/

hdfs dfs -get /user/malam/yelp/results/tip_sentiment2

cd yelp/results/tip_sentiment/tip_sentiment2

cat 00* > tip_sentiment2.csv

scp malam@129.150.79.19:/home/malam/yelp/results/tip_sentiment/tip_sentiment2/tip_sentiment2.csv ~/
