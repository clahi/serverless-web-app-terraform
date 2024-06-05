resource "aws_amplify_app" "my-amplify-app" {
  name       = "wildrydes-app"
  repository = "https://github.com/clahi/serverless-web-app-terraform.git"

  build_spec = <<-EOT
    version: 0.1
    frontend:
      phases:
        preBuild:
          commands:
            - yarn install
        build:
          commands:
            - yarn run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  access_token = var.access-token
}

resource "aws_amplify_branch" "amplify-branch" {
  app_id      = aws_amplify_app.my-amplify-app.id
  branch_name = var.branch_name
}