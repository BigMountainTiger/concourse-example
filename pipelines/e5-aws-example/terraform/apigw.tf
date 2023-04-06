resource "aws_lambda_permission" "apigw_api-executor_permission" {
  statement_id  = "${local.project-name}-executor_permission"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_executor.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_rest_api" "api_gw" {
  name = "${local.project-name}-AGW"
}

resource "aws_api_gateway_method" "api_root_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  resource_id   = aws_api_gateway_rest_api.api_gw.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_root_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gw.id
  resource_id             = aws_api_gateway_rest_api.api_gw.root_resource_id
  http_method             = aws_api_gateway_method.api_root_get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api_executor.invoke_arn
}

resource "aws_api_gateway_deployment" "test_api_gw_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gw.body))
  }

  depends_on = [
    aws_api_gateway_method.api_root_get_method,
    aws_api_gateway_integration.api_root_get_integration
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.test_api_gw_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  stage_name    = "deploy"
}
