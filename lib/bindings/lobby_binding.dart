import 'package:kiwigames/controllers/controllers.dart';
import 'package:get/get.dart';

class LobbyBinding implements Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<LobbyController>()) {
      Get.put(
        LobbyController(
          screen: 'principale',
          host: false,
        ),
        permanent: true,
      );
    }
  }
}
