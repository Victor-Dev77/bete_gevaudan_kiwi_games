import 'dart:convert';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/io.dart';

class Server {
  Server._internal();
  static final Server _instance = Server._internal();
  static Server get instance => _instance;

  //WebSocketChannel _channel =
     // IOWebSocketChannel.connect(Uri.parse('wss://kiwigames.ovh'));
  // wss://www.kiwigames.ovh/socket.io/?EIO=4&transport=websocket
  // wss://ws.ifelse.io/
  // ws://10.0.2.2:3000 - localhost emulateur Android

  listen() {
    LobbyController.to.gameStream.stream.listen(
      (message) {
        print("message server: $message");
        _filterData(message);
      },
      onDone: () => print("on done"),
      onError: (error) => print(error),
    );
  }

  _send(Map<String, dynamic> data) {
    LobbyController.to.sendToLobby(data);
  }

  close() {
    //_channel.sink.close(status.goingAway);
  }

  _filterData(Map<dynamic, dynamic> data) {
    if (data["type"] == "notif new user") {
      print(data["data"]);
      //PlayerController.to.modifListPlayer(data["data"]);
    }
    if (data["message"] == "startGame") {
      PlayerController.to.switchGameTour(GameTour.DISTRIB_ROLE);
    }
  }

  startGame() {
    _send({
      "message": "startGame",
      "type": "to all",
    });
  }

  firstConnect() {
    _send({
      "type": "first connect",
      "screen": "user",
      "host": "true",
      "user": {"username": "Victor"}
    });
  }
}
