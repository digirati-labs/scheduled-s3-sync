output "role_unique_id" {
  value = "${data.aws_iam_role.sync.unique_id}"
}
