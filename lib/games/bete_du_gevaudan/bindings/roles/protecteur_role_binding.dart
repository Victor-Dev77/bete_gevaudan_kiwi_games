import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/protecteur/protecteur_role_controller.dart';
import 'package:get/get.dart';

class ProtecteurRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProtecteurRoleController());
  }
}
