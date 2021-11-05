import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/sorciere/sorciere_role_controller.dart';

class SorciereRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SorciereRoleController(), permanent: true);
  }
}
