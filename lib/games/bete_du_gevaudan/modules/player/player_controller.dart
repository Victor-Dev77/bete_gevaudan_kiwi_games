import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/distrib_role.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/vote/vote_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';

enum GameTour {
  INTRO_GAME,
  DISTRIB_ROLE,
  SLEEP,
  MARIEUSE_WAKE,
  MARIEUSE_SLEEP,
  MEDIUM_WAKE,
  MEDIUM_SLEEP,
  MALE_ALPHA_WAKE,
  MALE_ALPHA_SLEEP,
  PROTECTEUR_WAKE,
  PROTECTEUR_SLEEP,
  WOLF_WAKE,
  WOLF_SLEEP,
  SORCIERE_WAKE,
  SORCIERE_SLEEP,
  WAKE,
  VOTE,
  RESULT_VOTE,
  END_TOUR,
  END_GAME
}

class PlayerController extends GetxController {
  static PlayerController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    Server.instance.listen();
    var players = LobbyController.to.userList;
    nbPlayerAlive = players.length;
    for (int i = 0; i < nbPlayerAlive; i++) {
      var p = players[i];
      listPlayer.add(Player(
          id: i,
          name: p.username,
          isHost: p.isHost,
          screen: p.screen ?? "user",
          isPrincipale: false));
    }
    listPlayerAlive.addAll(listPlayer);
    _player = listPlayer.firstWhere(
        (element) => element.name == LobbyController.to.username,
        orElse: () => Player(
            id: 100,
            name: "principale",
            isHost: false,
            screen: "principale",
            isPrincipale: true));
    print("user player device: $_player");
    print("list of players: $listPlayer");
  }

  GameTour gameTour = GameTour.INTRO_GAME;
  int nbTour = 0;
  Duration durationChrono = Duration(seconds: 5);
  Player _player = Player(id: 4, name: "Victor");
  Player get player => this._player;
  int nbPlayerAlive = 0;
  int nbPlayerReady = 0;
  List<Player> listPlayer = [];
  List<Player> listPlayerAlive = [];
  Player? playerKillByVote;

  // Specific Role Player
  List<Player>? married; // Marieuse
  Player? playerWillKillIfMaleAlphaDie; // Male Alpha
  Player? playerProtected; // Protecteur
  List<Player> playerKillByLoup = []; // Loup Garou

  bool attributTypePlayer() {
    if (player.isPrincipale) {
      var distrib = DistribRole.distribRoles(listPlayer.length);
      distrib.entries.forEach((element) {
        int indexPlayer =
            listPlayerAlive.indexWhere((item) => item.id == element.key);
        print('index player: $indexPlayer / ${element.key}');
        if (indexPlayer != -1) {
          listPlayerAlive[indexPlayer].typePlayer = element.value;
        }
      });
      listPlayer = listPlayerAlive;
      print(listPlayerAlive);
      Server.instance.sendRolePlayer(listPlayer);
      return true;
    }
    return false;
  }

  addPlayerReady() {
    if (player.isPrincipale) nbPlayerReady++;
    if (nbPlayerReady == listPlayer.length) {
      nbPlayerReady = 0;
      Server.instance.nextPage(GameTour.SLEEP);
    }
  }

  addPlayerReadyVoted() {
    if (player.isPrincipale) nbPlayerReady++;
    if (nbPlayerReady == nbPlayerAlive) {
      nbPlayerReady = 0;
      playerKillByVote = VoteController.to.getResultVote();
      if (playerKillByVote != null)
        Server.instance.deadPlayer(playerKillByVote!);
      Server.instance.nextPage(GameTour.RESULT_VOTE);
    }
  }

  bool containsRole(TypePlayer typePlayer) {
    bool res = false;
    for (int i = 0; i < listPlayer.length; i++) {
      if (listPlayer[i].typePlayer == typePlayer && !listPlayer[i].isKill) {
        /*if (nbTour > 0 &&
            (typePlayer == TypePlayer.MARIEUSE ||
                typePlayer == TypePlayer.MALE_ALPHA))
          res = false;
        else*/
        res = true;
        return res;
      }
    }
    return res;
  }

  String getUsernameForTypePlayer(TypePlayer typePlayer) {
    String res = "";
    listPlayerAlive.forEach((element) {
      if (element.typePlayer == typePlayer) {
        res = element.name;
      }
    });
    return res;
  }

  switchGameTour(GameTour tour) {
    gameTour = tour;
    switchRolePage();
  }

  switchRolePage() {
    print(gameTour);
    switch (gameTour) {
      case GameTour.INTRO_GAME:
        break;
      case GameTour.DISTRIB_ROLE:
        Get.offAllNamed(Routes.DISTRIB_ROLE);
        break;
      case GameTour.SLEEP:
        Get.offAllNamed(Routes.SLEEP);
        break;
      case GameTour.MARIEUSE_WAKE:
        if (containsRole(TypePlayer.MARIEUSE))
          Get.offAllNamed(Routes.MARIEUSE_ROLE_WAKE);
        else
          switchGameTour(GameTour.MEDIUM_WAKE);
        break;
      case GameTour.MARIEUSE_SLEEP:
        Get.offAllNamed(Routes.MARIEUSE_ROLE_SLEEP);
        break;
      case GameTour.MEDIUM_WAKE:
        if (containsRole(TypePlayer.MEDIUM))
          Get.offAllNamed(Routes.MEDIUM_ROLE_WAKE);
        else
          switchGameTour(GameTour.MALE_ALPHA_WAKE);
        break;
      case GameTour.MEDIUM_SLEEP:
        Get.offAllNamed(Routes.MEDIUM_ROLE_SLEEP);
        break;
      case GameTour.MALE_ALPHA_WAKE:
        if (containsRole(TypePlayer.MALE_ALPHA))
          Get.offAllNamed(Routes.MALE_ALPHA_ROLE_WAKE);
        else
          switchGameTour(GameTour.PROTECTEUR_WAKE);
        break;
      case GameTour.MALE_ALPHA_SLEEP:
        Get.offAllNamed(Routes.MALE_ALPHA_ROLE_SLEEP);
        break;
      case GameTour.PROTECTEUR_WAKE:
        if (containsRole(TypePlayer.PROTECTEUR))
          Get.offAllNamed(Routes.PROTECTEUR_ROLE_WAKE);
        else
          switchGameTour(GameTour.WOLF_WAKE);
        break;
      case GameTour.PROTECTEUR_SLEEP:
        Get.offAllNamed(Routes.PROTECTEUR_ROLE_SLEEP);
        break;
      case GameTour.WOLF_WAKE:
        Get.offAllNamed(Routes.LOUP_ROLE_WAKE);
        break;
      case GameTour.WOLF_SLEEP:
        Get.offAllNamed(Routes.LOUP_ROLE_SLEEP);
        break;
      case GameTour.SORCIERE_WAKE:
        if (containsRole(TypePlayer.SORCIERE))
          Get.offAllNamed(Routes.SORCIERE_ROLE_WAKE);
        else
          switchGameTour(GameTour.WAKE);
        break;
      case GameTour.SORCIERE_SLEEP:
        Get.offAllNamed(Routes.SORCIERE_ROLE_SLEEP);
        break;
      case GameTour.WAKE:
        Get.offAllNamed(Routes.WAKE);
        break;
      case GameTour.VOTE:
        Get.offAllNamed(Routes.VOTE);
        break;
      case GameTour.RESULT_VOTE:
        Get.offAllNamed(Routes.RESULT_VOTE);
        break;
      case GameTour.END_TOUR:
        break;
      case GameTour.END_GAME:
        break;
    }
  }

  modifListPlayer(List<String> players) {
    var length = players.length;
    for (int i = 0; i < length; i++) {
      listPlayer[i].name = players[i];
    }
  }

  killPlayer(int id) {
    int index = listPlayer.indexWhere((item) => item.id == id);
    if (index != -1) {
      print(listPlayer[index].name);
      listPlayer[index].isKill = true;
      nbPlayerAlive--;
      listPlayerAlive.removeWhere((item) => item.id == id);
      if (nbPlayerAlive <= 1) {
        nbTour = 0;
        gameTour = GameTour.END_GAME;
        print("FIN DE PARTIE !! AUCUN JOUEUR");
        Get.offAllNamed(Routes.END_GAME);
      } else {
        /*PlayerController.to.gameTour =
            PlayerController.to.gameTour == GameTour.KILL_WOLF
                ? GameTour.WAIT_1
                : GameTour.WAIT_2;
        Future.delayed(Duration(seconds: 2), () {
          if (PlayerController.to.gameTour == GameTour.WAIT_1) {
            PlayerController.to.gameTour = GameTour.KILL_FARMER;
            Get.offAllNamed(Routes.KILL);
          } else {
            nbTour++;
            PlayerController.to.gameTour = GameTour.SLEEP;
            Get.offAllNamed(Routes.END_GAME); //TODO: SLEEP
          }
        });*/
      }
    }
  }

  reloadGame() {
    print("REJOUER");
  }

  quitGame() {
    print("QUITTER");
  }

  Widget sleepPlayerPageWidget() {
    return Stack(
      children: [
        Opacity(
          opacity: 0.3,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(player.imageTypePlayer),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      player.nameTypePlayer,
                      style:
                          TextStyle(color: ConstantColor.white, fontSize: 22),
                    ),
                  ),
                ),
                Expanded(flex: 3, child: Container()),
                Spacer()
              ],
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: married?.length == 2 ? _buildMarried() : Container(),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  "FERMEZ LES YEUX, VOUS DORMEZ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstantColor.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ],
    );
  }

  _buildMarried() {
    if (married == null) return Container();
    var idMe = married!.indexWhere((item) => item.id == player.id);
    if (idMe == -1) return Container();
    var otherPlayer = idMe == 0 ? married![1] : married![0];
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidHeart,
                  color: ConstantColor.white,
                ),
                SizedBox(height: 5),
                Text(
                  otherPlayer.name,
                  style: TextStyle(color: ConstantColor.white, fontSize: 17),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget killPlayerWidget() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ConstantImage.tombe),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          "TU ES MORT",
          style: TextStyle(color: ConstantColor.white, fontSize: 27),
        ),
      ),
    );
  }
}
