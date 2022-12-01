#!/usr/bin/env bash

export SLACK_WEBHOOK_LAB_EVENTS_ARN=$(terraform output notify_slack_lab_events_arn | sed 's/"//g')
export SLACK_WEBHOOK_LAB_ALERTS_ARN=$(terraform output notify_slack_lab_alerts_arn | sed 's/"//g')

export ACCOUNT=$1
export AWS_ACCOUNT_ID=$(cat ${ACCOUNT}.auto.tfvars.json | jq -r .aws_account_id)
export AWS_ASSUME_ROLE=$(cat ${ACCOUNT}.auto.tfvars.json | jq -r .aws_assume_role)

echo "DEBUG:"
echo "EVENT_WEBHOOK: ${SLACK_WEBHOOK_LAB_EVENTS_ARN}"
echo "ALERT_WEBHOOK: ${SLACK_WEBHOOK_LAB_ALERTS_ARN}"

if [[ $(aws sns publish --topic-arn ${SLACK_WEBHOOK_LAB_EVENTS_ARN} --message "Pipeline test for SNS topic = Slack #lab-events channel" | grep MessageId) != "" ]]; then
  echo "Event Message Posted"
else
  echo "Event Message Not Posted"
  exit 1
fi

if [[ $(aws sns publish --topic-arn ${SLACK_WEBHOOK_LAB_ALERTS_ARN} --message "Pipeline test for SNS topic = Slack #lab-events channel" | grep MessageId) != "" ]]; then
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
export AWS_DEFAULT_REGION=$(cat ${ACCOUNT}.auto.tfvars.json | jq -r .aws_region)

rspec spec/*
