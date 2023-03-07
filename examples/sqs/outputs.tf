################################################################################
# Queue
################################################################################

output "queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.sqs.id
}

output "queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.sqs.arn
}

output "queue_url" {
  description = "Same as `queue_id`: The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.sqs.url
}

output "queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.sqs.name
}

################################################################################
# Dead Letter Queue
################################################################################

output "dead_letter_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.dlq.id
}

output "dead_letter_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.dlq.arn
}

output "dead_letter_queue_url" {
  description = "Same as `dead_letter_queue_id`: The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.dlq.url
}

output "dead_letter_queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.dlq.name
}