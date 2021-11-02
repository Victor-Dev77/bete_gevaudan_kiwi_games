import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:get/get.dart';

class DistribRoleController extends GetxController {
  RxBool _playerHasRole = false.obs;
  bool get playerHasRole => _playerHasRole.value;

  RxBool _showRoleDetail = false.obs;
  bool get showRoleDetail => _showRoleDetail.value;

  @override
  void onInit() {
    super.onInit();
    PlayerController.to.attributTypePlayer();
    _playerHasRole.value = true;
  }

  clickShowRole() {
    _showRoleDetail.value = true;
  }

  closeShowRole() {
    _showRoleDetail.value = false;
  }

  clickReady() {
    PlayerController.to.switchGameTour(GameTour.SLEEP);
  }
}
