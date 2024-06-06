data "aws_cognito_user_pools" "this" {
  name = aws_cognito_user_pool.WildRydes.name
}

resource "aws_api_gateway_rest_api" "WildRydes" {
  name = "WildRydes"

  #   endpoint_configuration {
  #     types = ["Edge optimized"]
  #   }
}

resource "aws_api_gateway_resource" "ride" {
  rest_api_id = aws_api_gateway_rest_api.WildRydes.id
  parent_id   = aws_api_gateway_rest_api.WildRydes.root_resource_id
  path_part   = "ride"

}

resource "aws_api_gateway_authorizer" "WildRydes" {
  name          = "WildRydes"
  type          = "COGNITO_USER_POOLS"
  rest_api_id   = aws_api_gateway_rest_api.WildRydes.id
  provider_arns = data.aws_cognito_user_pools.this.arns
}

resource "aws_api_gateway_method" "POST" {
  rest_api_id   = aws_api_gateway_rest_api.WildRydes.id
  resource_id   = aws_api_gateway_resource.ride.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.WildRydes.id

}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.WildRydes.id
  resource_id             = aws_api_gateway_resource.ride.id
  http_method             = aws_api_gateway_method.POST.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.RequestUnicorn.invoke_arn
}

resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.WildRydes.id
  resource_id = aws_api_gateway_resource.ride.id
  http_method = aws_api_gateway_method.POST.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.WildRydes.id
  resource_id = aws_api_gateway_resource.ride.id
  http_method = aws_api_gateway_method.POST.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code

  # cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.POST,
    aws_api_gateway_integration.lambda_integration
  ]
}

resource "aws_api_gateway_deployment" "deploymet" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.WildRydes.id
  stage_name  = "prod"
}