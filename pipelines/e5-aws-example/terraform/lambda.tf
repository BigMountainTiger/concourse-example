locals {
  api_executor_zip = "../.artifacts/api-executor.zip"
}

resource "aws_lambda_function" "api_executor" {
  function_name    = "${local.project-name}-api-executor"
  filename         = local.api_executor_zip
  source_code_hash = filebase64sha256(local.api_executor_zip)
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "src.app.lambdaHandler"
  runtime          = "python3.10"
}
