output "amplify_app_url" {
  description = "The url to access the app"
  value       = aws_amplify_app.my-amplify-app.default_domain
}

output "amplify_app_id" {
  value = aws_amplify_app.my-amplify-app.id
}

output "aws_ses_email_arn" {
  value = aws_ses_email_identity.approved_email.arn
}

output "user_pool_id" {
  value = aws_cognito_user_pool.WildRydes.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.WildRydesWebApp.id
}