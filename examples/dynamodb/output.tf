output "table_name_1" {
  value       = aws_dynamodb_table.example-dynamodb-table.name
  description = "DynamoDB table name"
}