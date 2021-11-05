import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/wake/wake_controller.dart';

class WakeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WakeController());
  }
}
