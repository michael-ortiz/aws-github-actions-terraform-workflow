module "s3_terraform_state" {
  source  = "michael-ortiz/s3-terraform-state/aws"
  version = "~> 1.0"

  state_bucket_names    = ["my-terraform-state-bucket-1234"] // Used in backend.tf to set S3 backend
  state_lock_table_name = "terraform-s3-state-lock"          // Used in backend.tf to set S3 backend
}

# Plan Role with ReadOnlyAccess - Creates OIDC Provider
module "github_actions_oidc_plan" {
  source  = "michael-ortiz/github-actions-oidc/aws"
  version = "~> 1.0"

  create_oidc_provider    = true
  role_name               = "github-actions-oidc-role-plan"
  repositories            = ["Organization/RepositoryName"]
  oidc_role_policies_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

# Apply Role with AdministratorAccess - Does not create OIDC Provider becase it was already created in the Plan Role
module "github_actions_oidc_apply" {
  source  = "michael-ortiz/github-actions-oidc/aws"
  version = "~> 1.0"

  create_oidc_provider    = false
  role_name               = "github-actions-oidc-role-apply"
  repositories            = ["Organization/RepositoryName"]
  oidc_role_policies_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}
