resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  log_group_name = var.log_group_name
  metric_transformation {
    name          = var.metric_filter_name != "" ? var.metric_filter_name : var.alarm_name
    namespace     = var.metric_namespace
    value         = var.metric_value
    default_value = var.default_value
    unit          = var.unit
  }
  name    = var.metric_filter_name != "" ? var.metric_filter_name : var.alarm_name
  pattern = var.pattern

}

resource "aws_cloudwatch_metric_alarm" "metric_alarm" {
  alarm_name          = var.alarm_name
  alarm_description   = var.alarm_description
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = aws_cloudwatch_log_metric_filter.metric_filter.name
  namespace           = var.metric_namespace
  period              = var.period
  threshold           = var.threshold
  statistic           = var.statistic

  alarm_actions             = var.alarm_action_arns
  ok_actions                = var.alarm_ok_actions
  insufficient_data_actions = var.alarm_insufficient_data_actions
  treat_missing_data        = var.treat_missing_data

  tags = var.tags
}
