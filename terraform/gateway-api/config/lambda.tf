locals {
  mylambda_function_name = "gatewayapi_post_new"
}
module "post_new" {
  source = "./lambda-module/"

  function_name       = local.mylambda_function_name
  handler             = "index.handler"
  lambda_iam_role_arn = aws_iam_role.execution_role.arn
  memory_size         = 512
  timeout             = 3
}

# See https://stackoverflow.com/a/52116074
data "aws_lambda_function" "post_new" {
  function_name = local.mylambda_function_name
  qualifier     = module.post_new.version
}

resource "aws_lambda_permission" "post_new" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.post_new.arn
  principal     = "apigateway.amazonaws.com"
  qualifier     = data.aws_lambda_function.post_new.version

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}

output "post_new_invoke_arn" {
  value = data.aws_lambda_function.post_new.invoke_arn
}

output "post_new_version" {
  value = data.aws_lambda_function.post_new.version
}
