variable "sync_s3_source" {}
variable "sync_s3_source_arn" {}
variable "sync_s3_target" {}
variable "sync_s3_target_arn" {}

variable "log_group_name" {}
variable "prefix" {}
variable "sync_identifier" {}
variable "region" {}

variable "sync_s3_docker_image" {
  default = "digirati/scheduled-s3-sync:latest"
}

variable "account_id" {}
variable "cluster_id" {}
variable "cron_expression" {}
