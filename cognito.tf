resource "aws_ses_email_identity" "approved_email" {
  email = "abdalamoha2022@gmail.com"
}

resource "aws_cognito_user_pool" "WildRydes" {
  name = "WildRydes"

  auto_verified_attributes = ["email"]

  email_configuration {
    source_arn = aws_ses_email_identity.approved_email.arn
    email_sending_account = "DEVELOPER"
    from_email_address = "abdalamoha2022@gmail.com"
  }
}

resource "aws_cognito_user_pool_client" "WildRydesWebApp" {
  name         = "WildRydesWebApp"
  user_pool_id = aws_cognito_user_pool.WildRydes.id
}