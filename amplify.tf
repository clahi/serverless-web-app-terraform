resource "aws_amplify_app" "my-amplify-app" {
  name       = "wildrydes-app"
  repository = "https://github.com/clahi/serverless-web-app-terraform.git"

  access_token = var.access-token
}

resource "aws_amplify_branch" "amplify-branch" {
  app_id      = aws_amplify_app.my-amplify-app.id
  branch_name = var.branch_name
}