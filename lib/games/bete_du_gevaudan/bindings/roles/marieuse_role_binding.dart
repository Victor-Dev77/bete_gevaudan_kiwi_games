import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/marieuse/marieuse_role_controller.dart';
import 'package:get/get.dart';

class MarieuseRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MarieuseRoleController(), permanent: true);
  }
}
