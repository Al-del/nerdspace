void testSocket(socket) async {
  Socket socket;
  try {
    socket = io('http://127.0.0.1:3000', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.connect();
    socket.on('testEvent', (data) => print(data));
  } 
  print("connected: ${socket.connected}");
}
