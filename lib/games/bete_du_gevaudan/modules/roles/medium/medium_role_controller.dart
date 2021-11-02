import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class MediumRoleController extends GetxController {
  Player? playerSelected;
  RxBool _isIdentityShow = false.obs;
  bool get isIdentityShow => _isIdentityShow.value;

  @override
  void onInit() {
    super.onInit();
  }

  clickPlayer(Player player) {
    playerSelected = player;
    update();
  }

  isPlayer(Player player) => player.id == playerSelected?.id;

  showIdentity() => _isIdentityShow.value = true;
}
