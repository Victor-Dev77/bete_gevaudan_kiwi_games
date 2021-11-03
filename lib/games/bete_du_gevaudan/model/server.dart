import 'dart:convert';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/distrib_role/distrib_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';

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
    if (data["message"] == "startGame") {
      PlayerController.to.switchGameTour(GameTour.DISTRIB_ROLE);
    } else if (data["message"].toString().contains("distrib_role-")) {
      _assignRoleToPlayer(data);
    } else if (data["message"] == "ready") {
      PlayerController.to.addPlayerReady();
    } else if (data["message"].toString().contains("GameTour.")) {
      GameTour tour = GameTour.values
          .firstWhere((e) => e.toString() == data["message"].toString());
      PlayerController.to.switchGameTour(tour);
    } else if (data["message"].toString().contains("married-")) {
      _assignMarriedPlayer(data);
    }
  }

  startGame() {
    _send({
      "message": "startGame",
      "type": "to all",
    });
  }

  sendRolePlayer(List<Player> listPlayer) {
    _send({
      "message": "distrib_role-${listPlayer.toString()}",
      "type": "to users",
    });
  }

  imReady() {
    _send({
      "message": "ready",
      "type": "to principale",
    });
  }

  nextPage(GameTour tour) {
    _send({
      "message": tour.toString(),
      "type": "to all",
    });
  }

  _assignRoleToPlayer(Map data) {
    var msg = data["message"].toString().substring("distrib_role-".length);
    List listOfMap = json.decode(msg);
    var index = listOfMap.indexWhere(
        (element) => element["id"] == PlayerController.to.player.id);
    if (index != -1) {
      TypePlayer type = TypePlayer.values.firstWhere(
          (e) => e.toString() == listOfMap[index]["typePlayer"].toString());
      PlayerController.to.player.setTypePlayer = type;
      DistribRoleController.to.setPlayerHasRole(true);
    }
    // chaque joueur applique les roles de sa liste de joueurs
    listOfMap.forEach((map) {
      var i = PlayerController.to.listPlayer
          .indexWhere((element) => element.id == map["id"]);
      if (i != -1) {
        PlayerController.to.listPlayer[i].setTypePlayer = TypePlayer.values
            .firstWhere((e) => e.toString() == map["typePlayer"].toString());
      }
    });
    PlayerController.to.listPlayerAlive = PlayerController.to.listPlayer;
  }

  marriedPlayers(List<Player> list) {
    _send({
      "message": "married-${list.toString()}",
      "type": "to users",
    });
  }

  _assignMarriedPlayer(Map data) {
    var msg = data["message"].toString().substring("married-".length);
    List listOfMap = json.decode(msg);
    var id1 = listOfMap[0]["id"];
    var id2 = listOfMap[1]["id"];
    var ip1 = PlayerController.to.listPlayer
        .indexWhere((element) => element.id == id1);
    var ip2 = PlayerController.to.listPlayer
        .indexWhere((element) => element.id == id2);
    if (ip1 != -1 && ip2 != -1) {
      PlayerController.to.married = [
        PlayerController.to.listPlayer[ip1],
        PlayerController.to.listPlayer[ip2]
      ];
    }
    print("players married => ${PlayerController.to.married}");
  }
}
