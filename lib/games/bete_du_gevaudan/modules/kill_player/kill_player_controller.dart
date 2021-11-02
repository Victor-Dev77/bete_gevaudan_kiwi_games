import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:get/get.dart';

class KillPlayerController extends GetxController {

  RxBool isPlayerSelected = false.obs;
  List<Player> _listPlayer = PlayerController.to.listPlayerAlive;

  selectPlayerToKill(Player player) {
    _listPlayer.forEach((item) {
      item.isSelectedToKill = false;
    });
    player.isSelectedToKill = !player.isSelectedToKill;
    isPlayerSelected.value = true;
    update();
  }

  Player getPlayerSelected() {
    int index = 0;
    for (int i = 0; i < _listPlayer.length; i++) {
      if (_listPlayer[i].isSelectedToKill) {
        index = i;
        break;
      }
    }
    return _listPlayer[index];
  }
}
