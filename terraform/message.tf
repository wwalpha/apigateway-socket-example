# --------------------------------------------------------------------------------
# Archive File - message
# --------------------------------------------------------------------------------
data "archive_file" "message" {
  type        = "zip"
  source_file = "../dist/message.js"
  output_path = "../dist/message.zip"
}

# --------------------------------------------------------------------------------
# AWS Lambda - message
# --------------------------------------------------------------------------------
module "message" {
  source = "github.com/wwalpha/terraform-module-registry/aws/lambda"

  publish            = false
  function_name      = "websocket-message"
  handler            = "message.handler"
  runtime            = "nodejs14.x"
  role_name          = "WebSocketMessageRole"
  timeout            = 5
  filename           = "${data.archive_file.message.output_path}"
  source_code_hash   = "${filebase64sha256(data.archive_file.message.output_path)}"
  trigger_principal  = "apigateway.amazonaws.com"
  trigger_source_arn = "arn:aws:execute-api:ap-northeast-1:${data.aws_caller_identity.current.account_id}:${var.api_id}/*/$default"

  role_policy_json = [
    "${data.aws_iam_policy_document.connection.json}"
  ]
}

# --------------------------------------------------------------------------------
# Connections 管理権限
# --------------------------------------------------------------------------------
data "aws_iam_policy_document" "connection" {
  statement {
    actions = [
      "execute-api:ManageConnections",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.api_id}/*"
    ]
  }
}
