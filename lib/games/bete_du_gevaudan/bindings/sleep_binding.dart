import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/sleep/sleep_controller.dart';

class SleepBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SleepController());
  }
}
