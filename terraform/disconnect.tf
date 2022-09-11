# --------------------------------------------------------------------------------
# Archive File - disconnect
# --------------------------------------------------------------------------------
data "archive_file" "disconnect" {
  type        = "zip"
  source_file = "../dist/disconnect.js"
  output_path = "../dist/disconnect.zip"
}

# --------------------------------------------------------------------------------
# AWS Lambda - disconnect
# --------------------------------------------------------------------------------
module "disconnect" {
  source = "github.com/wwalpha/terraform-module-registry/aws/lambda"

  publish            = false
  function_name      = "websocket-disconnect"
  handler            = "disconnect.handler"
  runtime            = "nodejs14.x"
  role_name          = "WebSocketDisconnectRole"
  timeout            = 5
  filename           = "${data.archive_file.disconnect.output_path}"
  source_code_hash   = "${filebase64sha256(data.archive_file.disconnect.output_path)}"
  trigger_principal  = "apigateway.amazonaws.com"
  trigger_source_arn = "arn:aws:execute-api:ap-northeast-1:${data.aws_caller_identity.current.account_id}:${var.api_id}/*/$disconnect"
}

