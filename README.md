# apigateway-socket-example

## Create API Gateway WebSocket

### Create API

```sh
aws apigatewayv2 create-api --name websocket-example --protocol-type WEBSOCKET --route-selection-expression "$request.body.message"

{
    "ApiEndpoint": "wss://hqep9lsfa9.execute-api.ap-northeast-1.amazonaws.com",
    "ApiId": "hqep9lsfa9",
    "ApiKeySelectionExpression": "$request.header.x-api-key",
    "CreatedDate": "2019-08-02T14:59:33Z",
    "Name": "websocket-example",
    "ProtocolType": "WEBSOCKET",
    "RouteSelectionExpression": ".body.message"
}
```

### Create Integration

```sh
aws apigatewayv2 create-integration --api-id hqep9lsfa9 --integration-type AWS --integration-uri arn:aws:apigateway:ap-northeast-1:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:xxxxxxxxxxxx:function:websocket-connect/invocations

{
    "ConnectionType": "INTERNET",
    "IntegrationId": "zgem940",
    "IntegrationMethod": "POST",
    "IntegrationResponseSelectionExpression": "${integration.response.body.errorMessage}",
    "IntegrationType": "AWS",
    "IntegrationUri": "arn:aws:apigateway:ap-northeast-1:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:xxxxxxxxxxxxxx:function:websocket-connect/invocations",
    "PassthroughBehavior": "WHEN_NO_MATCH",
    "TimeoutInMillis": 29000
}
```

## Test

```sh
yarn test

Server Connected...
I will send hello to server.
Message from server: Hi Client
Server Disonnected...
```
