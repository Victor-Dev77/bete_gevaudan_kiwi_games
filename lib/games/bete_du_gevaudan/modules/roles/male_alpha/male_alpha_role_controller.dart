import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class MaleAlphaRoleController extends GetxController {
  Player? playerSelected;

  @override
  void onInit() {
    super.onInit();
  }

  clickPlayer(Player player) {
    playerSelected = player;
    update();
  }

  isPlayer(Player player) => player.id == playerSelected?.id;
}
