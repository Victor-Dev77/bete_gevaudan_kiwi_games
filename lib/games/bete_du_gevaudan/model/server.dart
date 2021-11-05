import 'dart:convert';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/distrib_role/distrib_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/loup/loup_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/male_alpha/male_alpha_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/marieuse/marieuse_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/medium/medium_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/protecteur/protecteur_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/sorciere/sorciere_role_controller.dart';

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
    // Start Game at begin
    if (data["message"] == "startGame") {
      PlayerController.to.switchGameTour(GameTour.DISTRIB_ROLE);
    }
    // Distrib Role
    else if (data["message"].toString().contains("distrib_role-")) {
      _assignRoleToPlayer(data);
    }
    // Wait player click Ready to launch Tour
    else if (data["message"] == "ready") {
      PlayerController.to.addPlayerReady();
    }
    // Change Page
    else if (data["message"].toString().contains("GameTour.")) {
      GameTour tour = GameTour.values
          .firstWhere((e) => e.toString() == data["message"].toString());
      PlayerController.to.switchGameTour(tour);
    }
    // Specific Role Marieuse
    else if (data["message"].toString().contains("married-")) {
      _assignMarriedPlayer(data);
    }
    // Specific Role Male Alpha
    else if (data["message"].toString().contains("playerChoiceMaleAlpha-")) {
      _assignMaleAlphaKillPlayer(data);
    }
    // Specific Role Protecteur
    else if (data["message"].toString().contains("choicePlayerToProtect-")) {
      _assignPlayerProtected(data);
    }
    // Specific Role Loup
    else if (data["message"].toString().contains("choicePlayerKillByLoup-")) {
      _assignPlayerKilledByLoup(data);
    }
    // Get finish Voice Off for player
    else if (data["message"]
        .toString()
        .contains(PlayerController.to.player.name)) {
      _makeReadyBtnVoiceOffFinish(data);
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

  // Specific Role Marieuse
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

  // Specific Role Male Alpha
  choicePlayerByMaleAlpha(Player player) {
    _send({
      "message": "playerChoiceMaleAlpha-[${player.toString()}]",
      "type": "to users",
    });
  }

  _assignMaleAlphaKillPlayer(Map data) {
    var msg =
        data["message"].toString().substring("playerChoiceMaleAlpha-".length);
    List listOfMap = json.decode(msg);
    var ip1 = PlayerController.to.listPlayer
        .indexWhere((element) => element.id == listOfMap[0]["id"]);
    if (ip1 != -1) {
      PlayerController.to.playerWillKillIfMaleAlphaDie =
          PlayerController.to.listPlayer[ip1];
    }
  }

  // Specific Role Protecteur
  choicePlayerToProtect(Player player) {
    _send({
      "message": "choicePlayerToProtect-[${player.toString()}]",
      "type": "to users",
    });
  }

  _assignPlayerProtected(Map data) {
    var msg =
        data["message"].toString().substring("choicePlayerToProtect-".length);
    List listOfMap = json.decode(msg);
    var ip1 = PlayerController.to.listPlayer
        .indexWhere((element) => element.id == listOfMap[0]["id"]);
    if (ip1 != -1) {
      PlayerController.to.playerProtected = PlayerController.to.listPlayer[ip1];
    }
  }

  // Specific Role Loup
  choicePlayerKillByLoup(Player player) {
    _send({
      "message": "choicePlayerKillByLoup-[${player.toString()}]",
      "type": "to users",
    });
  }

  _assignPlayerKilledByLoup(Map data) {
    var msg =
        data["message"].toString().substring("choicePlayerKillByLoup-".length);
    List listOfMap = json.decode(msg);
    var ip1 = PlayerController.to.listPlayer
        .indexWhere((element) => element.id == listOfMap[0]["id"]);
    if (ip1 != -1) {
      PlayerController.to.playerKillByLoup =
          PlayerController.to.listPlayer[ip1];
    }
  }

  finishVoiceOff(String username, TypePlayer typePlayer) {
    _send({
      "message": "$username-${typePlayer.toString()}",
      "type": "to one",
      "username": username
    });
  }

  _makeReadyBtnVoiceOffFinish(Map data) {
    var typeMsg = data["message"]
        .toString()
        .substring("${PlayerController.to.player.name}-".length);
    TypePlayer type =
        TypePlayer.values.firstWhere((e) => e.toString() == typeMsg.toString());
    switch (type) {
      case TypePlayer.LOUP:
        LoupRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.SORCIERE:
        SorciereRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.PETITE_FILLE:
        break;
      case TypePlayer.MEDIUM:
        MediumRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.PROTECTEUR:
        ProtecteurRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.LE_PETIT_FARCEUR:
        break;
      case TypePlayer.MARIEUSE:
        MarieuseRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.MALE_ALPHA:
        MaleAlphaRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.VILLAGEOIS:
        break;
    }
  }
}
