import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketTestScreen(),
    );
  }
}

class WebSocketTestScreen extends StatefulWidget {
  @override
  _WebSocketTestScreenState createState() => _WebSocketTestScreenState();
}

class _WebSocketTestScreenState extends State<WebSocketTestScreen> {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://localhost:8000/ws/notifications/');
  TextEditingController _controller = TextEditingController();
  String _response = '';

  @override
  void initState() {
    super.initState();
    channel.stream.listen((message) {
      setState(() {
        _response = message;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test WebSocket'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Message à envoyer'),
          ),
          ElevatedButton(
            child: Text('Envoyer'),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                channel.sink.add(_controller.text);
              }
            },
          ),
          SizedBox(height: 20),
          Text('Réponse: $_response'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
