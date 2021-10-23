import 'package:kiwigames/controllers/controllers.dart';
import 'package:get/get.dart';

class LobbyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LobbyController());
  }
}
