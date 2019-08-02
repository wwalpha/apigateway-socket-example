import WebSocket from 'ws';

const ws = new WebSocket('wss://vez8mtffgc.execute-api.ap-northeast-1.amazonaws.com/v1');

// Connect open
ws.on('open', () => {
  console.log('Server Connected...');

  console.log('I will send hello to server.');

  ws.send('Hello Server');
});

// we got a message
ws.on('message', (data: WebSocket.Data) => {
  console.log('Message from server:', data);

  ws.close();
});

// Connect close
ws.on('close', () => {
  console.log('Server Disonnected...');
});
