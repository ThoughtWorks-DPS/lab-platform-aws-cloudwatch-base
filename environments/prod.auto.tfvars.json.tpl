{
  "aws_default_region": "us-east-1",
  "aws_account_id": "{{ op://empc-lab/aws-dps-1/aws-account-id }}",
  "aws_assume_role": "DPSPlatformAWSCloudwatchBaseRole",
  "cluster_name": "prod-us-east-1",

  "slack_webhook_lab_events_url": "{{ op://empc-lab/svc-slack/lab-events }}",
  "slack_webhook_lab_alerts_url": "{{ op://empc-lab/svc-slack/lab-prod-events }}",
}
  