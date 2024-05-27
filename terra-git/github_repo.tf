terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
provider "github" {
    token = "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"
}
resource "github_repository" "terra-test" {
    name = "terra-test"
    description = "terraform testing"
    visibility = "public"
}