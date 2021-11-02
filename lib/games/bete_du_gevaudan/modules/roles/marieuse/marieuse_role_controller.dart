import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class MarieuseRoleController extends GetxController {
  static MarieuseRoleController get to => Get.find();

  List<Player> listPlayerUnis = [];

  @override
  void onInit() {
    super.onInit();
  }

  bool isUnionValid() => listPlayerUnis.length == 2;

  bool isContainPlayer(Player player) {
    return listPlayerUnis.contains(player);
  }

  clickPlayer(Player player) {
    if (listPlayerUnis.length < 2 && !listPlayerUnis.contains(player))
      listPlayerUnis.add(player);
    else if (listPlayerUnis.contains(player))
      listPlayerUnis.remove(player);
    else
      listPlayerUnis[1] = player;
    update();
  }
}
