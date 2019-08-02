# --------------------------------------------------------------------------------
# Archive File - connect
# --------------------------------------------------------------------------------
data "archive_file" "connect" {
  type        = "zip"
  source_file = "../dist/connect.js"
  output_path = "../dist/connect.zip"
}

# --------------------------------------------------------------------------------
# AWS Lambda - connect
# --------------------------------------------------------------------------------
module "connect" {
  source = "github.com/wwalpha/terraform-module-registry/aws/lambda"

  publish            = false
  function_name      = "websocket-connect"
  handler            = "connect.handler"
  runtime            = "nodejs10.x"
  role_name          = "WebSocketConnectRole"
  filename           = "${data.archive_file.connect.output_path}"
  source_code_hash   = "${filebase64sha256(data.archive_file.connect.output_path)}"
  timeout            = 5
  trigger_principal  = "apigateway.amazonaws.com"
  trigger_source_arn = "arn:aws:execute-api:ap-northeast-1:${data.aws_caller_identity.current.account_id}:${var.api_id}/*/$connect"

  role_policy_json = [
  ]
}
