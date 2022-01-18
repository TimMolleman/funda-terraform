# Gateway API and resource
resource "aws_api_gateway_rest_api" "funda_api" {
  name        = "funda_api"
  description = "API for Funda housing endpoints"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.funda_api.id
  parent_id   = aws_api_gateway_rest_api.funda_api.root_resource_id
  path_part   = "{proxy+}"
}

# Gateway methods
resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.funda_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.funda_api.id
  resource_id   = aws_api_gateway_rest_api.funda_api.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

# Gateway integrations
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.funda_api.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.funda-api.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.funda_api.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.funda-api.invoke_arn
}

resource "aws_api_gateway_method_response" "method_response_200" {
  http_method = aws_api_gateway_method.proxy.http_method
  resource_id = aws_api_gateway_method.proxy.resource_id
  rest_api_id = aws_api_gateway_rest_api.funda_api.id
  status_code = "200"
  response_models = {
    "application/json" : "Empty"
  }
}

resource "aws_api_gateway_method_response" "method_response_200_root" {
  http_method = aws_api_gateway_method.proxy_root.http_method
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  rest_api_id = aws_api_gateway_rest_api.funda_api.id
  status_code = "200"
  response_models = {
    "application/json" : "Empty"
  }
}

# API gateway deployment
resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = aws_api_gateway_rest_api.funda_api.id
  stage_name  = "prod"

  depends_on = [
    "aws_api_gateway_integration.lambda",
    "aws_api_gateway_integration.lambda_root",
  ]
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.funda-api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.funda_api.execution_arn}/*/*/"
}

resource "aws_lambda_permission" "api_gateway_permission2" {
  statement_id  = "AllowAPIGatewayInvoke2"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.funda-api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.funda_api.execution_arn}/*/*/*"
}