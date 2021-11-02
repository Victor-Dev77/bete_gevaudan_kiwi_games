import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/distrib_role.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/routes/app_pages.dart';
import 'package:get/get.dart';

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
      listPlayer.add(Player(id: i, name: p.username, isHost: p.isHost, screen: p.screen ?? "user", isPrincipale: false));
    }
    listPlayerAlive.addAll(listPlayer);
    _player = listPlayer.firstWhere((element) => element.name == LobbyController.to.username, orElse: () => Player(id: 100, name: "principale", isHost: false, screen: "principale", isPrincipale: true));
    print("user player device: $_player");
    print("list of players: $listPlayer");
  }


  GameTour gameTour = GameTour.INTRO_GAME;
  int nbTour = 0;
  Duration durationChrono = Duration(seconds: 5);
  Player _player = Player(id: 4, name: "Victor");
  Player get player => this._player;
  int nbPlayerAlive = 0;
  List<Player> listPlayer = [];
  List<Player> listPlayerAlive = [];

  bool attributTypePlayer() {
    var distrib = DistribRole.distribRoles(listPlayer.length);
    distrib.entries.forEach((element) {
      int indexPlayer =
          listPlayerAlive.indexWhere((item) => item.id == element.key);
      if (indexPlayer != -1) {
        listPlayerAlive[indexPlayer].typePlayer = element.value;
      }
    });
    listPlayer = listPlayerAlive;
    _player = listPlayer[3];
    print(listPlayerAlive);
    return true;
  }

  bool containsRole(TypePlayer typePlayer) {
    bool res = false;
    listPlayerAlive.forEach((element) {
      if (element.typePlayer == typePlayer) {
        res = true;
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
        //Get.offAllNamed(Routes.VOTE);
        break;
      case GameTour.RESULT_VOTE:
        //Get.offAllNamed(Routes.RESULT_VOTE);
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
}
