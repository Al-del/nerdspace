import 'package:web_socket_channel/web_socket_channel.dart';

void sendMessage(String message) {
  print(message);

  WebSocketChannel channel;

  try {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3000'));
    channel.sink.add(message);

    channel.stream.listen((message) {
      print(message);
      channel.sink.close();
    });
  } catch (e) {
    print(e);
  }
}
