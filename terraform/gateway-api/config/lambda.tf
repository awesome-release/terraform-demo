module "post_metrics" {
  source = "./lambda-module/"

  function_name       = "gatewayapi_post_metrics"
  handler             = "index.datadogHandler"
  lambda_iam_role_arn = aws_iam_role.execution_role.arn
  memory_size         = 512
  timeout             = 3
}

# See https://stackoverflow.com/a/52116074
data "aws_lambda_function" "post_metrics" {
  function_name = "gatewayapi_post_metrics"
  qualifier     = module.post_metrics.version
}

resource "aws_lambda_permission" "post_metrics" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.post_metrics.arn
  principal     = "apigateway.amazonaws.com"
  qualifier     = data.aws_lambda_function.post_metrics.version

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}

output "post_metrics_invoke_arn" {
  value = data.aws_lambda_function.post_metrics.invoke_arn
}

output "post_metrics_version" {
  value = data.aws_lambda_function.post_metrics.version
}
