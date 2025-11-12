include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment_hcl = find_in_parent_folders("environment.hcl")
  environment     = read_terragrunt_config(local.environment_hcl).locals.environment
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-aws.git//modules/iam_role_github_actions?ref=${values.version}"
}

inputs = {
  name          = values.name
  github_repo   = values.github_repo
  github_branch = values.github_branch
  tags = {
    environment = "${local.environment}"
  }
}
