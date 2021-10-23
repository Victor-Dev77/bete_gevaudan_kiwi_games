import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/app/app.dart';
import 'package:kiwigames/bindings/bindings.dart';

void main() {
  Paint.enableDithering = true;
  runApp(const Kiwigames());
}

class Kiwigames extends StatelessWidget {
  static final AppTheme appTheme = AppTheme();
  static final AppPages appPages = AppPages();

  const Kiwigames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kiwi-Games',
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('fr', 'FR'),
      theme: appTheme.primaryTheme,
      unknownRoute: appPages.notFoundPage,
      getPages: appPages.appPages,
      initialBinding: UserBinding(),
      initialRoute: '/',
      defaultTransition: Transition.fadeIn,
    );
  }
}

/* import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://www.kiwigames.ovh/socket.io/?EIO=4&transport=websocket'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                print(snapshot.data);
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      print('sening');
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
} */
