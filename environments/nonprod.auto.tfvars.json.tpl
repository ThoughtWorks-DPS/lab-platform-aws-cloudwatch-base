{
  "aws_default_region": "us-east-2",
  "aws_account_id": "{{ op://empc-lab/aws-dps-2/aws-account-id }}",
  "aws_assume_role": "DPSPlatformAWSCloudwatchBaseRole",
  "cluster_name": "sandbox-us-east-2",

  "slack_webhook_lab_events_url": "{{ op://empc-lab/svc-slack/lab-events }}",
  "slack_webhook_lab_alerts_url": "{{ op://empc-lab/svc-slack/lab-sandbox-events }}"
}
