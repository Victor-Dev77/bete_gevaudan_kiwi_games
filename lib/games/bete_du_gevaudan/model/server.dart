import 'dart:convert';
import 'package:get/get.dart';
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
import 'package:kiwigames/games/bete_du_gevaudan/modules/vote/vote_controller.dart';

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
    else if (data["message"] == "readySleep") {
      PlayerController.to.addPlayerReady();
    }
    // Wait player click vote to launch Result Vote
    else if (data["message"] == "readyResultVote") {
      PlayerController.to.addPlayerReadyVoted();
    }
    // Wait player click vote loup
    else if (data["message"].toString().contains("voteLoup-")) {
      _checkVotePlayerLoup(data);
    }
    // Change Page
    else if (data["message"].toString().contains("GameTour.")) {
      GameTour tour = GameTour.values
          .firstWhere((e) => e.toString() == data["message"].toString());
      PlayerController.to.switchGameTour(tour);
    }
    // Increase Nb Tour
    else if (data["message"].toString().contains("increaseNBTour-")) {
      _assignNbTour(data);
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
    // Specific Role Loup
    else if (data["message"]
        .toString()
        .contains("choiceSorcierePlayerToKill-")) {
      _assignSorcierePlayerToKill(data);
    }
    // Dead Player
    else if (data["message"].toString().contains("dead-")) {
      _checkDeadPlayer(data);
    }
    // Vote Player
    else if (data["message"].toString().contains("vote-")) {
      _checkVotePlayer(data);
    }
    // Send List Player
    else if (data["message"].toString().contains("sendListPlayer-")) {
      _assignListPlayer(data);
    }
    // Get finish Voice Off for player
    else if (data["message"]
        .toString()
        .contains("ready-${PlayerController.to.player.name}-")) {
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
      "type": "to all",
    });
  }

  imReady() {
    _send({
      "message": "readySleep",
      "type": "to host",
    });
  }

  imReadyVoted() {
    _send({
      "message": "readyResultVote",
      "type": "to principale",
    });
  }

  selectPlayerVoteLoup(Player player) {
    _send({
      "message": "voteLoup-[${player.toString()}]",
      "type": "to host",
    });
  }

  _checkVotePlayerLoup(Map data) {
    var msg = data["message"].toString().substring("voteLoup-".length);
    List listOfMap = json.decode(msg);
    var ip1 = PlayerController.to.listPlayer
        .indexWhere((element) => element.name == listOfMap[0]["name"]);
    print("joueur index vote loup $ip1 /// ${PlayerController.to.listPlayer}");
    if (ip1 != -1) {
      PlayerController.to
          .addPlayerReadyVotedLoup(PlayerController.to.listPlayer[ip1]);
    }
  }

  nextPage(GameTour tour) {
    _send({
      "message": tour.toString(),
      "type": "to all",
    });
  }

  increaseNBTour(int nbTour) {
    _send({
      "message": "increaseNBTour-$nbTour",
      "type": "to all",
    });
  }

  _assignNbTour(Map data) {
    var msg = data["message"].toString().substring("increaseNBTour-".length);
    var tour = int.parse(msg);
    PlayerController.to.nbTour = tour;
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
  }

  // Specific Role Marieuse
  marriedPlayers(List<Player> list) {
    _send({
      "message": "married-${list.toString()}",
      "type": "to all",
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
      "type": "to all",
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
      "type": "to all",
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
  choicePlayerKillByLoup(List<Player> list) {
    _send({
      "message": "choicePlayerKillByLoup-${list.toString()}",
      "type": "to all",
    });
  }

  _assignPlayerKilledByLoup(Map data) {
    var msg =
        data["message"].toString().substring("choicePlayerKillByLoup-".length);
    List listOfMap = json.decode(msg);
    List<Player> listOfPlayer = [];
    listOfMap.forEach((item) {
      var ip1 = PlayerController.to.listPlayer
          .indexWhere((element) => element.id == item["id"]);
      if (ip1 != -1) {
        listOfPlayer.add(PlayerController.to.listPlayer[ip1]);
      }
    });
    PlayerController.to.playerKillByLoup = listOfPlayer;
  }

  finishVoiceOff(String username, TypePlayer typePlayer) {
    if (typePlayer == TypePlayer.LOUP) {
      var list = username.split("/");
      list.forEach((element) {
        _send({
          "message": "ready-$element-${typePlayer.toString()}",
          "type": "to one",
          "username": element
        });
      });
    } else
      _send({
        "message": "ready-$username-${typePlayer.toString()}",
        "type": "to one",
        "username": username
      });
  }

  _makeReadyBtnVoiceOffFinish(Map data) {
    var typeMsg = data["message"]
        .toString()
        .substring("ready-${PlayerController.to.player.name}-".length);
    TypePlayer type =
        TypePlayer.values.firstWhere((e) => e.toString() == typeMsg.toString());
    switch (type) {
      case TypePlayer.LOUP:
        if (Get.isRegistered<LoupRoleController>())
          LoupRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.SORCIERE:
        if (Get.isRegistered<SorciereRoleController>())
          SorciereRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.PETITE_FILLE:
        break;
      case TypePlayer.MEDIUM:
        if (Get.isRegistered<MediumRoleController>())
          MediumRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.PROTECTEUR:
        if (Get.isRegistered<ProtecteurRoleController>())
          ProtecteurRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.LE_PETIT_FARCEUR:
        break;
      case TypePlayer.MARIEUSE:
        if (Get.isRegistered<MarieuseRoleController>())
          MarieuseRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.MALE_ALPHA:
        if (Get.isRegistered<MaleAlphaRoleController>())
          MaleAlphaRoleController.to.setVoiceOffFinish();
        break;
      case TypePlayer.VILLAGEOIS:
        break;
    }
  }

  deadPlayer(Player player) {
    _send({
      "message": "dead-[${player.toString()}]",
      "type": "to all",
    });
  }

  _checkDeadPlayer(Map data) {
    var msg = data["message"].toString().substring("dead-".length);
    List listOfMap = json.decode(msg);
    listOfMap.forEach((list) {
      var ip1 = PlayerController.to.listPlayer
          .indexWhere((element) => element.id == list["id"]);
      if (ip1 != -1) {
        PlayerController.to.listPlayer[ip1].isKill = true;
        PlayerController.to.nbPlayerAlive--;
        if (PlayerController.to.listPlayer[ip1].typePlayer ==
                TypePlayer.LE_PETIT_FARCEUR &&
            !PlayerController.to.player.isPrincipale &&
            PlayerController.to.player.typePlayer != TypePlayer.LOUP &&
            PlayerController.to.player.typePlayer != TypePlayer.MALE_ALPHA) {
          PlayerController.to.deadPetitFarceur();
        }
      }
      if (list["id"] == PlayerController.to.player.id) {
        PlayerController.to.player.isKill = true;
      }
    });

    print("NB PLAYER ALIVE: ${PlayerController.to.nbPlayerAlive}");
    print("NB PLAYERS STATUS: ${PlayerController.to.listPlayer}");
  }

  deadPlayerList(List<Player> list) {
    _send({
      "message": "dead-${list.toString()}",
      "type": "to all",
    });
  }

  selectPlayerVote(Player player) {
    _send({
      "message": "vote-[${player.toString()}]",
      "type": "to principale",
    });
  }

  _checkVotePlayer(Map data) {
    var msg = data["message"].toString().substring("vote-".length);
    var auteur = data["auteur"];
    List listOfMap = json.decode(msg);
    var ip1 = PlayerController.to.listPlayer
        .indexWhere((element) => element.id == listOfMap[0]["id"]);
    if (ip1 != -1) {
      PlayerController.to.listPlayer[ip1].isSelectedToKill = true;
      var ip2 = PlayerController.to.listPlayer
          .indexWhere((element) => element.name == auteur["username"]);
      VoteController.to.updatePlayersVoted(PlayerController.to.listPlayer[ip1],
          PlayerController.to.listPlayer[ip2]);
    }
  }

  sendListPlayer(List<Player> listPlayer) {
    _send({
      "message": "sendListPlayer-$listPlayer",
      "type": "to all",
    });
  }

  _assignListPlayer(Map data) {
    var msg = data["message"].toString().substring("sendListPlayer-".length);
    List listOfMap = json.decode(msg);
    var list = listOfMap.map((map) {
      return Player.fromJson(map);
    });
    PlayerController.to.listPlayer = list.toList();
  }

  // Specific Role Sorciere
  choiceSorcierePlayerToKill(Player player) {
    _send({
      "message": "choiceSorcierePlayerToKill-[${player.toString()}]",
      "type": "to all",
    });
  }

  _assignSorcierePlayerToKill(Map data) {
    var msg = data["message"]
        .toString()
        .substring("choiceSorcierePlayerToKill-".length);
    List listOfMap = json.decode(msg);
    var ip1 = PlayerController.to.listPlayer
        .indexWhere((element) => element.id == listOfMap[0]["id"]);
    if (ip1 != -1) {
      PlayerController.to.playerSorciereToKill =
          PlayerController.to.listPlayer[ip1];
    }
  }
}
