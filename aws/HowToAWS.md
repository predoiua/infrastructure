
## AWS Services

- Kinesis = streaming data
- Glue = AWS Glue is a serverless ETL
- IAM = Identity and Access Management
- RDS = Relational Data Sevice

## AWS cli

~~~
sudo apt install python3
sudo apt install python3-pip
pip3 install --upgrade awscli
sudo apt install awscli
aws --version
~~~

### Kinesis

~ Kafka, Google DataFlow
Kinesis < Shard < Log

### Usage

~~~
aws configure
ads kinesis list-streams
aws kinesis describe-stream --stream-name input_stream
aws kinesis put-record --stream-name input_stream --partition-key 1 --data 1
aws kinesis get-shard-iterator --stream-name input_stream --partition-key 1 --data 1
~~~