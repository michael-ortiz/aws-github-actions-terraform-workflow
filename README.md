## Terraform AWS GitHub Actions Plan / Apply Reusable Worfkflow

A simple reusable workflow that allows you to run Terraform Plan, Applies or Destroys using GitHub Actions.

Ensure to configure your AWS Credentials.

To configure an OIDC IAM Role for your GitHub repository, use this module:

https://github.com/michael-ortiz/terraform-aws-github-actions-oidc

To configure you S3 Terraform Backend in AWS, use this module:

https://github.com/michael-ortiz/terraform-aws-s3-terraform-state

Enjoty!

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
    secrets:
      # Recommended
      PLAN_IAM_ROLE_ARN: ${{ secrets.PLAN_IAM_ROLE_ARN }}
      APPLY_IAM_ROLE_ARN: ${{ secrets.APPLY_IAM_ROLE_ARN }}
      # Optional
      # AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      # AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```