output "notify_slack_lab_alerts_arn" {
  value = module.notify_slack_lab_alerts.slack_topic_arn
}

output "notify_slack_lab_events_arn" {
  value = module.notify_slack_lab_events.slack_topic_arn
}
