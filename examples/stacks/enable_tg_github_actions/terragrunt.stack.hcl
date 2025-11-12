locals {
  # Sets the reference of the source code to:
  version = coalesce(
    get_env("GITHUB_HEAD_REF", ""), # PR branch name (only set in PRs)
    get_env("GITHUB_REF_NAME", ""), # Branch/tag name
    try(run_cmd("git", "rev-parse", "--abbrev-ref", "HEAD"), ""),
    "main" # fallback
  )

  github_username  = "ConsciousML"
  github_repo_name = "terragrunt-template-catalog-aws"
}

unit "github_oidc_provider" {
  source = "${get_repo_root()}/units/oidc_provider"
  path   = "github_oidc_provider"

  values = {
    version         = local.version
    url             = "https://token.actions.githubusercontent.com"
    client_id_list  = ["sts.amazonaws.com"]
    thumbprint_list = []
  }
}

unit "iam_role_github_actions" {
  source = "${get_repo_root()}/units/iam_role_github_actions"
  path   = "iam_role_github_actions"

  values = {
    version          = local.version
    name             = "github-actions-terragrunt-role"
    github_username  = local.github_username
    github_repo_name = local.github_repo_name
    github_branch    = "*"
  }
}

unit "github_secrets" {
  source = "${get_repo_root()}/units/github_secrets"
  path   = "github_secrets"

  values = {
    version          = local.version
    github_token     = get_env("TF_VAR_github_token")
    github_repo_name = local.github_repo_name
  }
}
