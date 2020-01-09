module "sync_task" {
  source = "git::https://github.com/digirati-co-uk/terraform-aws-modules.git//tf/modules/services/tasks/base/?ref=v2.0"

  environment_variables = {
    SOURCE = "${var.sync_s3_source}"
    TARGET = "${var.sync_s3_target}"
  }

  environment_variables_length = 2

  prefix           = "${var.prefix}"
  log_group_name   = "${var.log_group_name}"
  log_group_region = "${var.region}"
  log_prefix       = "${var.prefix}-sync-${var.sync_identifier}"

  family = "${var.prefix}-sync-${var.sync_identifier}"

  container_name = "${var.prefix}-sync-${var.sync_identifier}"

  cpu_reservation    = 0
  memory_reservation = 128

  docker_image = "${var.sync_s3_docker_image}"
}

data "aws_iam_policy_document" "sync_bucket_access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:PutObject",
    ]

    resources = [
      "${var.sync_s3_target_arn}",
      "${var.sync_s3_target_arn}/${var.sync_s3_target_path}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "${var.sync_s3_source_arn}",
      "${var.sync_s3_source_arn}/${var.sync_s3_source_path}",
    ]
  }
}

resource "aws_iam_role_policy" "sync_bucket_access" {
  name   = "${var.prefix}-sync-bucket-access"
  role   = module.sync_task.role_name
  policy = data.aws_iam_policy_document.sync_bucket_access.json
}

module "sync" {
  source = "git::https://github.com/digirati-co-uk/terraform-aws-modules.git//tf/modules/services/tasks/scheduled/?ref=v2.0"

  family              = "${var.prefix}-sync-${var.sync_identifier}"
  task_role_name      = "${module.sync_task.role_name}"
  region              = "${var.region}"
  account_id          = "${var.account_id}"
  cluster_arn         = "${var.cluster_id}"
  schedule_expression = "${var.cron_expression}"
  desired_count       = 1
  task_definition_arn = "${module.sync_task.task_definition_arn}"
}
