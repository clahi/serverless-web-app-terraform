resource "aws_amplify_app" "my-amplify-app" {
  name         = "wildrydes-app"
  repository   = "https://github.com/clahi/serverless-web-app-terraform"
  access_token = var.access-token

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  # Auto Branch Creattion
  enable_auto_branch_creation = true

  # The default patterns added by the Amplify Console.
  auto_branch_creation_patterns = [
    "*",
    "*/**",
  ]

  auto_branch_creation_config {
    # Enable auto build for the created branch.
    enable_auto_build = true
  }
}

resource "aws_amplify_branch" "master" {
  app_id      = aws_amplify_app.my-amplify-app.id
  branch_name = "main"

  stage = "PRODUCTION"

  environment_variables = {
    "ENV" = "production"
  }
}