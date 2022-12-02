#!/usr/bin/env bash

export ACCOUNT=$1
export AWS_ACCOUNT_ID=$(cat ${ACCOUNT}.auto.tfvars.json | jq -r .aws_account_id)
export AWS_ASSUME_ROLE=$(cat ${ACCOUNT}.auto.tfvars.json | jq -r .aws_assume_role)
export AWS_DEFAULT_REGION=$(cat ${ACCOUNT}.auto.tfvars.json | jq -r .aws_region)

if [[ $(aws sns publish --topic-arn arn:aws:sns:us-east-2:${AWS_ACCOUNT_ID}:slack-lab-events-topic --message "Pipeline test for SNS topic = Slack #lab-events channel" | grep MessageId) != "" ]]; then
  echo "Event Message Posted"
else
  echo "Event Message Not Posted"
  exit 1
fi

if [[ $(aws sns publish --topic-arn arn:aws:sns:us-east-2:${AWS_ACCOUNT_ID}:slack-lab-alerts-topic --message "Pipeline test for SNS topic = Slack #lab-events channel" | grep MessageId) != "" ]]; then
  echo "Alerts Message Posted"
else
  echo "Alerts Message Not Posted"
  exit 1
fi

# run awspec tests
aws sts assume-role --output json --role-arn arn:aws:iam::${AWS_ACCOUNT_ID}:role/${AWS_ASSUME_ROLE} --role-session-name lab-platform-aws-cloudwatch-base-test > credentials

export AWS_ACCESS_KEY_ID=$(cat credentials | jq -r ".Credentials.AccessKeyId")
export AWS_SECRET_ACCESS_KEY=$(cat credentials | jq -r ".Credentials.SecretAccessKey")
export AWS_SESSION_TOKEN=$(cat credentials | jq -r ".Credentials.SessionToken")


rspec spec/*
