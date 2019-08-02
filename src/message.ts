import { APIGatewayProxyEvent } from 'aws-lambda';
import { ApiGatewayManagementApi } from 'aws-sdk';

export const handler = async (event: APIGatewayProxyEvent): Promise<any> => {
  console.log(event);

  const { connectionId, domainName, stage } = event.requestContext;

  const apigateway = new ApiGatewayManagementApi({ endpoint: `${domainName}/${stage}` });
  await apigateway
    .postToConnection({
      ConnectionId: connectionId as string,
      Data: 'Hi Client',
    })
    .promise();

  return {
    statusCode: 200,
    isBase64Encoded: false,
  };
};
