## Terraform AWS GitHub Actions Plan / Apply Reusable Worfkflow

A simple reusable workflow that allows you to run Terraform Plan, Applies or Destroys using GitHub Actions.

Ensure to configure your AWS Credentials.

To configure an OIDC IAM Role for your GitHub repository, use this module:

https://github.com/michael-ortiz/terraform-aws-github-actions-oidc

To configure you S3 Terraform Backend in AWS, use this module:

https://github.com/michael-ortiz/terraform-aws-s3-terraform-state

## Usage

```yaml
name: Deploy IaC

jobs:
  deploy:
    name: Terraform Deploy
    uses: michael-ortiz/aws-github-actions-terraform-workflow/.github/workflows/terraform-workflow.yaml@v1
    with:
      action: apply # Optional: plan, destroy, apply
      tf-version: latest
      aws-region: us-east-1
      environment: production
      terraform_vars: 'foo=bar,bar=foo'
    secrets:
      # Recommended
      PLAN_IAM_ROLE_ARN: ${{ secrets.PLAN_IAM_ROLE_ARN }}
      APPLY_IAM_ROLE_ARN: ${{ secrets.APPLY_IAM_ROLE_ARN }}
      # Optional
      # AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      # AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## Manual Approval for Applies

To use manual approvals, you must pass an `environment` input to the workflow and in GitHub, and configure and `Environment` in your reposiutory Settings. Ensure the name of the environemnt matches the name of the environment created on the settings page.

More information on how to set this up here:

https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment

## Demo

In order to deploy, you must comment out the `backend.tf` code, and deploy manually using CLI into your AWS Account.
Once a `terraform.tfstate` is generated, you must copy the `.tfstate` file into S3 bucket state destination that you configured in the S3 backend in `backend.tf` and `main.tf` or reference the plan output to get the S3 bucket and DynamoDB table name.

Once the file is copied, uncomment the commented code, remove the generated terraform files in your project:

```
rm rf .terraform*
```

Next, run `terraform init` and `terraform plan`. If your local AWS Credentials have access to read from S3, the plan should succeed and should be reading the state from S3.

Finally, to implement this in your GitHub Repository Actions, copy the plan outputs of the `apply_role_arn` and `plan_role_arn` values, and pass them as secrets to the reusable workflow `terraform-workflow.yaml`. See example on `Usage` section on how to set this up.

Enjoy!
