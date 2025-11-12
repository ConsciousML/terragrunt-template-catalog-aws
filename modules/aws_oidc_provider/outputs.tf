output "arn" {
  description = "The ARN of the OIDC provider (used in IAM role trust policies)"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}
