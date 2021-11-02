import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/loup/loup_role_controller.dart';

class LoupRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoupRoleController());
  }
}
