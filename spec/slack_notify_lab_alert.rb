require 'awspec'

describe sns_topic(ENV['SLACK_WEBHOOK_LAB_ALERTS_ARN']) do
  it { should exist }
end
