variable "sqs_queue_name"{
  description = "The name of different SQS to be created"
  type        = string
  default = "main_queue"
}

variable "dead_queue_name"{
  description = "The name of different Dead Queues to be created"
  type        = string
  default = "dead_letter"
}

variable "max_receive_count" {
    type = number
    default = 4
}