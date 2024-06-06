output "amplify_app_url" {
  description = "The url to access the app"
  value       = aws_amplify_app.my-amplify-app.default_domain
}

output "amplify_app_id" {
  value = aws_amplify_app.my-amplify-app.id
}