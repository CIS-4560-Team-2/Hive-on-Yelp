--Creating table raw_business from the yelp_academic_dataset_business.json file. This json file is saved in the /user/malam/yelp/business directory of HDFS file system
create external table raw_business (json_response string) stored as textfile location '/user/malam/yelp/business';

--Creating table raw_checkin from the yelp_academic_dataset_checkin.json file. This json file is saved in the /user/malam/yelp/checkin directory of HDFS file system
create external table raw_checkin (json_response string) stored as textfile location '/user/malam/yelp/checkin';

--Creating table raw_review from the yelp_academic_dataset_review.json file. This json file is saved in the /user/malam/yelp/review directory of HDFS file system
create external table raw_review (json_response string) stored as textfile location '/user/malam/yelp/review';

--Creating table raw_tip from the yelp_academic_dataset_tip.json file. This json file is saved in the /user/malam/yelp/tip directory of HDFS file system
create external table raw_tip (json_response string) stored as textfile location '/user/malam/yelp/tip';

--Creating table raw_user from the yelp_academic_dataset_user.json file. This json file is saved in the /user/malam/yelp/user directory of HDFS file system
create external table raw_user (json_response string) stored as textfile location '/user/malam/yelp/user';