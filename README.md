# scheduled-s3-sync

## Environment Variables

| Name   | Description                      |
|--------|----------------------------------|
| SOURCE | S3 URL of synchronisation source |
| TARGET | S3 URL of synchronisation target |


## Terraform module

### Parameters

| Name                 | Description                                            | Default                           |
|----------------------|--------------------------------------------------------|-----------------------------------|
| sync_s3_source       | source in ARN format                                   |                                   |
| sync_s3_target       | target in ARN format                                   |                                   |
| log_group_name       | CloudWatch log group name                              |                                   |
| prefix               | Prefix for resources                                   |                                   |
| sync_identifier      | Unique name for this synchronisation                   |                                   |
| region               | AWS region                                             |                                   |
| sync_s3_docker_image | Docker image URL                                       | digirati/scheduled-s3-sync:latest |
| account_id           | AWS account ID                                         |                                   |
| cluster_id           | ECS cluster ID to run on                               |                                   |
| cron_expression      | Cron scheduling expression in form `cron(x x x x x x)` |                                   |

### Output

| Name           | Description                                                                     |
|----------------|---------------------------------------------------------------------------------|
| unique_role_id | Unique ID of task's IAM role, to be used in external account's bucket policies. |
