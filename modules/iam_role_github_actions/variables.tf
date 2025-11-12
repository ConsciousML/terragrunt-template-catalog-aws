variable "name" {
  description = "Name of the IAM role"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository in the format 'org/repo'"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch name or pattern (use '*' for all branches)"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the IAM role"
  type        = map(string)
  default     = {}
}
