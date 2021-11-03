import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlayerController(), permanent: true);
  }
}
