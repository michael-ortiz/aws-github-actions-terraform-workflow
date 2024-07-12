output "apply_role_arn" {
  description = "The ARN of the role to be assumed by the apply job"
  value       = module.github_actions_oidc_apply.oidc_role_arn
}

output "plan_role_arn" {
  description = "The ARN of the role to be assumed by the plan job"
  value       = module.github_actions_oidc_apply.oidc_role_arn
}

output "state_bucket_names" {
  description = "The names of the S3 buckets used for Terraform state storage"
  value       = module.s3_terraform_state.state_bucket_names
}

output "state_lock_table_name" {
  description = "The name of the DynamoDB table used for Terraform state locking"
  value       = module.s3_terraform_state.state_lock_table_name
}