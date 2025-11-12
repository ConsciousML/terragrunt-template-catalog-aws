data "aws_caller_identity" "current" {}

resource "aws_iam_role" "github_actions" {
  name = var.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            #"token.actions.githubusercontent.com:sub" = "repo:${var.github_username}/${var.github_repo_name}:ref:refs/heads/${var.github_branch}"
            "token.actions.githubusercontent.com:sub" : "repo:${var.github_username}/${var.github_repo_name}:${var.github_branch}"
          }
          StringEquals = {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = var.tags
}
