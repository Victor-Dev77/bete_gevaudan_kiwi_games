import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/medium/medium_role_controller.dart';
import 'package:get/get.dart';

class MediumRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MediumRoleController());
  }
}
