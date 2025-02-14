# AWS cloudwatch metric filter alarm Terraform module

Terraform module that creates AWS CloudWatch metric filter and alarms

## Usage

```hcl
module "my_cloudwatch_metric_filter_alarm" {
  source = "aniketvaidhya/cloudwatch-metric-filter-alarm/aws"

  log_group_name   = "MyLogGroup"
  metric_namespace = "MyMetricNamespace"
  pattern          = "ERROR"
  alarm_name       = "MyAlarm"
}
```

## Examples

The following example creates a CloudWatch Log Group, Alarm and SNS Topic. The Alarm monitors the Log Group for "ERROR" and if there are more than five occurrences within one hour the Alarm will go into an "ALARM" state and a notification will be sent to the SNS Topic

```hcl
resource "aws_cloudwatch_log_group" "MyLogGroup" {
  name = "MyLogGroup"
}

resource "aws_sns_topic" "MyTopic" {
  name         = "my-sns-topic"
  display_name = "my sns topic"
}

module "my_metric_filter_alarm" {
  source = "aniketvaidhya/metric-filter-alarm/aws"

  log_group_name    = aws_cloudwatch_log_group.MyLogGroup.name
  metric_namespace  = "MyMetricNamespace"
  pattern           = "ERROR"
  alarm_name        = "MyFunctionErrorAlarm"

  period            = "60"
  threshold         = "5"
  statistic         = "Max"

  # Optional SNS topic ARNs for alarm actions
  alarm_actions = [
    "arn:aws:sns:us-west-2:123456789012:my-sns-topic"
  ]

    # Optional OK actions
  ok_actions = [
    "arn:aws:sns:us-west-2:123456789012:my-sns-topic"
  ]

  # Optional insufficient data actions
  insufficient_data_actions = [
    "arn:aws:sns:us-west-2:123456789012:my-sns-topic"
  ]
}
```
