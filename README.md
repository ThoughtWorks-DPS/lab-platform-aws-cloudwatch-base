<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/EMPCPlatformStarterKitsImage.png?sanitize=true" width=350/>
	</p>
	<br />
	<a href="https://aws.amazon.com"><img src="https://img.shields.io/badge/-deployed-blank.svg?style=social&logo=amazon"></a>
	<br />
  <h3>lab-platform-aws-cloudwatch-base</h3>
	<a href="https://app.circleci.com/pipelines/github/ThoughtWorks-DPS/lab-platform-aws-cloudwatch-base"><img src="https://circleci.com/gh/ThoughtWorks-DPS/lab-platform-aws-cloudwatch-base.svg?style=shield"></a> <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
</div>
<br />

This pipeline manages those CloudWatch configurations which are Account level and shared across multiple resource specific configurations. This will be an evolving pipeline.   

### SNS topics for sending message to pre-defined slack channels  

E.g., configure CloudWatch Alerts to include these sns topic messages to target alerts to the appropriate DPS slack channels.  

_nonprod account_ (sandbox cluster)
arn:aws:sns:us-east-2:090950721693:slack-lab-events-topic  >> DPS Slack #lab-events channel
arn:aws:sns:us-east-2:090950721693:slack-lab-alerts-topic  >> DPS Slack #lab-sandbox-alerts channel

_prod account_ (prod cluster)
arn:aws:sns:us-east-2:481538974648:slack-lab-alerts-topic  >> DPS Slack #lab-events channel
arn:aws:sns:us-east-2:481538974648:slack-lab-alerts-topic  >> DPS Slack #lab-prod-alerts channel
