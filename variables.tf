variable "aws_default_region" {}
variable "aws_assume_role" {}

variable "aws_account_id" {
  type        = string
  sensitive   = true
}

# use this cluster instance VPC for Lambda notifiers
variable "cluster_name" {}

variable "slack_webhook_lab_events_url" {
  sensitive = true
}

variable "slack_webhook_lab_alerts_url" {
  sensitive = true
}
