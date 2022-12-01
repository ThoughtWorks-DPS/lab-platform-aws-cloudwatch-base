resource "aws_kms_ciphertext" "slack_webhook_lab_alerts_url" {
  plaintext = var.slack_webhook_lab_alerts_url
  key_id    = aws_kms_key.url_encrypt.arn
}

module "notify_slack_lab_alerts" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 5.4.1"

  slack_webhook_url = aws_kms_ciphertext.slack_webhook_lab_alerts_url.ciphertext_blob
  slack_channel     = "lab-sandbox-alerts"
  slack_username    = "pipeline-bash"
  slack_emoji       = ":aws:"
  kms_key_arn       = aws_kms_key.url_encrypt.arn

  sns_topic_name    = "slack-lab-alerts-topic"

  lambda_function_name           = "notify_slack_lab_alerts"
  lambda_description             = "Lambda function which sends notifications to DPS alerts Slack channel"
  lambda_function_vpc_subnet_ids = data.aws_subnets.intra.ids
  log_events                     = true

  tags = {
    Name = "sns-messages-to-slack-lab-alerts"
  }
}
