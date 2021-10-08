locals {
  output_filename = "/var/tmp/${var.function_name}.zip"
  source_dir      = "${path.module}/src/${var.function_name}"
}

resource "null_resource" "build" {
  triggers = {
    indexjs         = filebase64sha256("${local.source_dir}/index.js")
    packageJSON     = filebase64sha256("${local.source_dir}/package.json")
    packageLockJSON = filebase64sha256("${local.source_dir}/package-lock.json")
  }

  provisioner "local-exec" {
    working_dir = local.source_dir
    command     = <<localexec
node -c *.js && \
npm run test && \
rm -rf node_modules/.bin && \
npm ci --production && \
rm -f ${local.output_filename} && \
zip -rq ${local.output_filename} index.js node_modules
localexec
  }
}

data "template_file" "zipfile" {
  template = filebase64sha256(local.output_filename)
  vars = {
    id = null_resource.build.id
  }
}

resource "aws_lambda_function" "this" {
  filename         = local.output_filename
  description      = "Created by terraform"
  memory_size      = var.memory_size
  timeout          = var.timeout
  function_name    = var.function_name
  role             = var.lambda_iam_role_arn
  handler          = var.handler
  runtime          = var.runtime
  publish          = true
  source_code_hash = data.template_file.zipfile.rendered

  environment {
    variables = {
      DEBUG = "true"
    }
  }

  tags = {
    purpose = "gateway-api"
  }
}

output "version" {
  value = aws_lambda_function.this.version
}
