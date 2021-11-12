import 'package:kiwigames/controllers/controllers.dart';
import 'package:get/get.dart';

class JoinLobbyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(JoinLobbyController());
  }
}
